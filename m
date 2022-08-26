Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530535A2D41
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbiHZRSI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiHZRSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 13:18:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E4CDF09B;
        Fri, 26 Aug 2022 10:18:03 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27QG75rp012626;
        Fri, 26 Aug 2022 10:17:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zqJrUzTrGJcUXDO+Xp68iugw1pyZpEltqdZPhEG/tXE=;
 b=Tr0pX9SG2D17QJ7LzNKUWnaxqaWXuQUcRL7v+2lTMCjBdnFFnihS5x7XmU7U4Qzk4DPm
 cWtygTnwmB5e202rvTvlf7Qd1DIT1TloQhPMlShJFJLH6x1Eofl5eBuOAHud9wK7c9Ce
 n/TvbCd6ZVsPTswgmITWXFyG3qtfwphuVmA= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j71dhghen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 10:17:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c39QCjQmXKkAGpj78OllX8sg39yBku0J9WCjQadqjlcgiYhn+WjTBk65SFeIXQ2GTt48E5mntr882vxLGPkvUpXlLwS0IqwEpg+HReOxb6Zt8Ahz2nc4Z569MquPXRibS5+R6TEI0eI1rKp/7DrLq2/4Q9Uh9lszpHe4CrLy4KO++Fxhor0ERKypb74EeevfSbqM3V5MS5x9hEzLIzqPdrnwQhQSSnW1u+QLlook5dByjcX9+9qLV5NyQT/PNNgHobxycPcdPkq8l68ws3hr3zMr9StkcW4PFesVgf7H+hG9lTF2m6huP+2+TdsBmmqVeFyzkCVfkk7KK3NXJlu9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqJrUzTrGJcUXDO+Xp68iugw1pyZpEltqdZPhEG/tXE=;
 b=csOEQobaASB3kCHmZaDxhJ6rfkBZEGQjGbZaTH24c+RQJlyD6v/LWbUW262SBxCuVvUBdP7l2K3OECMMGjZpL/eQXCdZHIJImicGOT8aWrchoqiPSOwur36dZtthGGo06RtNH5861RALPD8quGnRjfvJInym6CoSDGEyvOPX0+/ykarvMEL5837zvCxDLD44hBUxNrG0ABtHWNHGHwpw7mR4BRP+Z3f9YuHK7ifkUq4TlTu0jSF6oBLLddrQJc7uXpWSRYfhpsN2X4dgrVyfcX8GR7xXi9eZ7YuU3Mqkr4iBdWG6wiQ/0Q4q0K+j3ZvsOJFMNncHrzfICe6fFFdy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4690.namprd15.prod.outlook.com (2603:10b6:806:19d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 17:17:45 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:17:45 +0000
Date:   Fri, 26 Aug 2022 10:17:41 -0700
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
Message-ID: <20220826171741.pdiqa4n4mls56bw3@kafai-mbp.dhcp.thefacebook.com>
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
 <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b6ea093-88cb-4020-6f0e-08da8786e407
X-MS-TrafficTypeDiagnostic: SA1PR15MB4690:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbqKR0eScrKifpNpPzCADAx8QxOkqwMyv5HbAbModVFs90YjBWsm8i7CMpDnx+gn5+0HXwakSqAGkgOqWzhZQuiqLSsB2dffHVnTvdTneDwHw4PJJEaJ1TtdPkJXLZk9UBV6xOBiYGiSCjyGbFhEiC1SezPt5hZlzOPZmeBHjzF8lAHCEbmSROZzbGp2EN3SnB8I5trGLjXT8Uw8NK0fJj/7hzFAA8BTrEU65uq0+hcnSO2wqJ0TOfpWYqh5KEcleay5rU6LlzDtycBJlxDQMks5KgEnWZbz0WT3eqkHvUJpugaXXYo+klAgQysaoSB03jkjxoeARde8mR8llOka2Y+ZudSMpZC9njM2ulpzvEmKz6RWFC0JfiJ/UjRMl9wOU6eGAk0HLqEyUv0YoLxHav7IxxLYZQKYkt0cYYe3pM6BzWxIlEVw9cEhFHuhSPjTmQConQ4QJhjTytIwHrY0mbvn8zIMXNWmlyL8ScGTP36sMnXloHGsgRB1ABpj+W3Qqv5B126MAi/L01r52oDLVHZvefk8FvfKiBLE2EgL/JoDgbDC4owIpBbwKFlrKPB+8VxH9LdD3LoKXh5zFs04mvahRfKApWHE8NuOlHKq/47u6lKK9qDpa9r1Ez8G5XIEg/gIaKEq++2XUVtPvhDLd/6gu60Pi4XWtoR8VHxuPLqhCAQbbdsDsRFHQBttWKqA91Gys0LLfAushwwttWBs5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(8676002)(66476007)(6916009)(66556008)(66946007)(54906003)(316002)(5660300002)(4326008)(2906002)(8936002)(7416002)(478600001)(1076003)(52116002)(86362001)(53546011)(6506007)(6666004)(6512007)(6486002)(9686003)(186003)(41300700001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ze6P6mC8Y1Tr09isdPHoHf0ia3YP5uLThx2B4uG4Ep+naBaxQVP6xBvQNZYM?=
 =?us-ascii?Q?us/RRuktBxWF3iTCdYwC3k2OZXQB9CR4xzYPlveNQ29LqCnijCUvj8wyefWq?=
 =?us-ascii?Q?Op+zsS3vM+oqmXkvwSgpkohpW0Zq+TArIkDpLP50TPn9e77cUV2F3EHW49Zl?=
 =?us-ascii?Q?7LuQ7RoCF6ZnHTZLGMIuO6L7tsAsKSQ5SPGA8qOPJgUrXAOXqUiBtxEYCr2P?=
 =?us-ascii?Q?QZit0VkevuuxPR9jo69NNzEcxk2kERcxPXRqJxUTWjLDCaM8k17PY8/fL1qS?=
 =?us-ascii?Q?iKLoaHbam3AQxOT8xdgGwmVVKB3dcKlL4+fLD7ETOHnMri2vszENNvm4kNIZ?=
 =?us-ascii?Q?gBTCJOX7CApDytTgcsHTRpfNJ7HmwcHyee5btVyZJpBtNTjGsripc6SwSQZt?=
 =?us-ascii?Q?0NtKlAPtyXkK5/bZCPNukuOsHJ+JmRITwX/NcESS6xSEG9R3883VsYZ3vmCE?=
 =?us-ascii?Q?sGFLY+6ezDeLovq2QLrS3peVPafxA/2PyajHkd4VJRhpB35zis5OuJbKLxiH?=
 =?us-ascii?Q?QQ/AGk9gyE2UqTQ9XdMR20l9PMTrE6ujiLo5bbWap/NQunHOryNzQikxODEF?=
 =?us-ascii?Q?e6H36JOU82RGiOIPgM7RhXzjNR+53c6T2eJFgp0tnWrx21NMtyWohxffCSrk?=
 =?us-ascii?Q?IjjGSj7kA9tG86/i1cBhna0+MKQWSbTOTNdQ4Xr1eo9S8h8yWnkLTWV9OIqy?=
 =?us-ascii?Q?SUo+wvUrHWbEv5/AUxwUo+ePA20+sge6ivuUGBcla/e+zEZT5tGwrboeznXe?=
 =?us-ascii?Q?9wa9ddNLmsgtOHuS+IqyKc1TtDv991CKKXOfN1IcQ6p28980a5gawIP1jywl?=
 =?us-ascii?Q?EYN7h+6YT10IWR7h7EMe571/os0hb0lPcwAF2KxsxuVDENAMyWNCBPCakB4H?=
 =?us-ascii?Q?yCDIOhcAjbi6PZpRZ14flmpneXqMLs5IjtEvw4noD7vklEhk4pQ65ClJESOG?=
 =?us-ascii?Q?Mf7hHOzQ/LMIhBym3EY89HrysZ8Rir4ke8kcndUgXSNoW0Z3hAyeaScCSzsk?=
 =?us-ascii?Q?wlj6NGcBX8GGgy0+CHoe8IJJciYVvVmBanxlpBrqMgRPy0GmGT+nSND58p3E?=
 =?us-ascii?Q?Z7MUTnsBS2kwwBGmqXgClgZxOtICDk4xGdlEhNUR5Nk6zgEoqJRwjajjR9xx?=
 =?us-ascii?Q?pRbwaqwriw81FsXY6B3j+fVNPhemMazxqvvyUVmUfpyDxI6JRLmqknVwNUKE?=
 =?us-ascii?Q?j18ad1pvel/d+OncBUzMZWUf/MXFA4Eq/XPKQ7OPmXh/NUSqOT6FzaNsU0XF?=
 =?us-ascii?Q?SKyaTCyKnazBYOEA1sdtl9J6LS0wTYQo9wMqNUqqsptdM3rJhjzJzpNsRbwi?=
 =?us-ascii?Q?o363NadOwJ5TPsEKXfFGS7Kfs4VDnpgWUc5TE6blXJnX3H+BxkD3ABY6xOYf?=
 =?us-ascii?Q?HxjQ0t2BBKOYZzpIoyG1SIdzJbDZ88X3S5VjziD/ZhbfKQQqRmaJ5C4MGKVm?=
 =?us-ascii?Q?+Xc6sHI8BN/vWjFmAlMFqCA26SESsMYHLvF17eZ/aFAzCDxNBaVTki++1Oxp?=
 =?us-ascii?Q?9v81xulxl1VgptgalQ76l+U9Q62Q9tjfGT8AFsh4/x2ljf+1ShV8dat7t2UD?=
 =?us-ascii?Q?nXo5OAt2Q/3qKg2q65pRPMZXEiGPh9pzuLddGDq0gWPzFPYj1flbdOGGEkws?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6ea093-88cb-4020-6f0e-08da8786e407
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:17:44.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/a4nSz9JN42jdBCzVdTtUxE79ne0YFDqsD7SkcmFLVaRSwOmqfwCKJ0BUAZgKPx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4690
X-Proofpoint-ORIG-GUID: OWE43n6iKADVexSylntR9zlFJyaPF2Tu
X-Proofpoint-GUID: OWE43n6iKADVexSylntR9zlFJyaPF2Tu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_09,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 12:13:54AM -0600, James Hilliard wrote:
> On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
> > > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > > >
> > > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> > > > > There is a potential for us to hit a type conflict when including
> > > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
> > > > > with linux/tcp.h to avoid this conflict.
> > > > >
> > > > > Fixes errors like:
> > > > > In file included from /usr/include/netinet/tcp.h:91,
> > > > >                  from progs/bind4_prog.c:10:
> > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
> > > > >    34 | typedef __INT8_TYPE__ int8_t;
> > > > >       |                       ^~~~~~
> > > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
> > > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
> > > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
> > > > >                  from progs/bind4_prog.c:9:
> > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
> > > > >    24 | typedef __int8_t int8_t;
> > > > >       |                  ^~~~~~
> > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
> > > > >    43 | typedef __INT64_TYPE__ int64_t;
> > > > >       |                        ^~~~~~~
> > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
> > > > >    27 | typedef __int64_t int64_t;
> > > > >       |                   ^~~~~~~
> > > > > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> > > > >
> > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
> > > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
> > > > >  2 files changed, 2 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > index 474c6a62078a..6bd20042fd53 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > > > @@ -6,8 +6,7 @@
> > > > >  #include <linux/bpf.h>
> > > > >  #include <linux/in.h>
> > > > >  #include <linux/in6.h>
> > > > > -#include <sys/socket.h>
> > > > > -#include <netinet/tcp.h>
> > > > These includes look normal to me.  What environment is hitting this.
> > >
> > > I was hitting this error with GCC 13(GCC master branch).
> > These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
> > so does it mean all existing programs need to change to use gcc 13 ?
> 
> Well I think it's mostly just an issue getting hit with GCC-BPF as it
> looks to me like a cross compilation host/target header conflict.
The users have been using these headers in the bpf progs.
The solution should be on the GCC-BPF side instead of changing
all bpf progs.
