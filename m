Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE35A53B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiH2SDz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2SDw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 14:03:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C0F98D07;
        Mon, 29 Aug 2022 11:03:50 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27THfxCd025011;
        Mon, 29 Aug 2022 11:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KDKeAuHmsSVxc9JCEuZ3aavE9/3rf0sycOdRfrcOLuk=;
 b=hdq/C9py1J6fyJp7/9b5YqVlSP4RdBc//O4eZHHZ7kSjcK+mqnnUz1VyYUvF2C4+mXCX
 RiRUpiPHH+vm0wKNxZONcVrH6Rmo08z8zqK7bPuGnTZevUV5rAD/lBPWa9heJDIDrQ+U
 86auyH/G+gMfnzTuljXzFNXi1idaxQl9/88= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7gcsuajg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 11:03:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbXND8DzLtGGErgrC6Ae2dfdetEeryW862Sg94rZkGBNlTBoUPUF32gGx5/xkATIkswice/VsXZbB7ku7ShF1F39UlHZa8OlEgg6ytd4KPEG2+n7+kYzIvTIRFwZQG4F+7+yPsSoXrgLRZdf21sxLvHS8gC11zmLYVS7mty6RAd/33Bbp0GlhAWJos6ZCt/q43vdI3zwDcyPxwru+N3rZNdgEjK5USi1kYcFvO2TiJCtJa1waH1qfHVnSGzI+4ylO/7nBpynl1GrRNNAv5gmuelezh8JXPoobk/adRbT0p2EZEXBJ/Y2kavd17/TzxgHIL0u5hhaJeBE4NtQVg9KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDKeAuHmsSVxc9JCEuZ3aavE9/3rf0sycOdRfrcOLuk=;
 b=dk/Yvc6bk/eCXYqabumpBkEDdRjpkD1ffCoMTbdFrBB1wgaD2tZtPVPWfnkCmbPK8NhfdMYdNhk6m6fL1fcG8Ju7LXVwSTw3bTZ5y2Dj6wFnLQByI5lVjUQ8f71S0OXSYELwMJ5nKO9la5/bC1DjJ6O/mKb6hSxCTy1FoU0QyWJCr3SrdyysacwclLwiKAE/ycyuDzQ4RkscF/MfnVWC9PgA8DuntpAP/tC5HDT9sLt6pEwFA8VSP38rfMXDi8ypl2SaF2TZ79z9Z9ZrTjJNdGnWQ3nVBZuZpNgu5+n2MaghTlUQxtNUNsERVsk1Yanl+6ATSMTVmhQIEGjAgFR1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM4PR15MB5380.namprd15.prod.outlook.com (2603:10b6:8:63::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 18:03:30 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 18:03:30 +0000
Date:   Mon, 29 Aug 2022 11:03:27 -0700
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
Subject: Re: [PATCH v2] selftests/bpf: Fix bind{4,6} tcp/socket header type
 conflict
Message-ID: <20220829180327.p6eakw5mahpaizck@kafai-mbp.dhcp.thefacebook.com>
References: <20220826052925.980431-1-james.hilliard1@gmail.com>
 <20220826230455.b5dcrvlmollglhx3@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rkSRsOtDcC1SCsGH59DyYQWJY_YRJAyt4a29yZP=SSLQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4rkSRsOtDcC1SCsGH59DyYQWJY_YRJAyt4a29yZP=SSLQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e53f64f-d5d1-4a13-5885-08da89e8c7c3
X-MS-TrafficTypeDiagnostic: DM4PR15MB5380:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nV9qDp69L2xh9zGwIqUKJgrslCPUDyOK7/Zh5g4IXhZGCFmt4qJnAIDHaK9TX7zenx0y+D8LTD4I/pCWisCJKLIwTap0h9OEZmnUjtZZILSAU+Ax8m1J72tLZGDdBILyM2Q6thPYCneYjCvVVGHDwXYviw6NQ0jTqXVDa/Msg4gr8VFmEvtQJf7HIzNA95jgubmYt8pDsaFNBozajscfy/0J7oeI8U6BVqdPZRX7ruUXifKaUXRF0/NMuSVRMBSrrBtdDv+E9Sz/HsP8ZtzYOJKGznEuXzDFCphIjaVVOU3uVSAikFCdjuZJjr6/5nOEmTzxIeI9cOBqrp7821cYPTFpqk+v/OJp+CYzgzc3iVUGSRUHKqdd7n5d2tmSXP16fKPS0ZMfX0X7vKg/ByEeZFL3m8h2vX8SJJ4zVzEvdkrFn63cZf/9cDODRZdRuegP/ixCx+ZLYWt/qEulOH/94fbTx4UV2QxfBBCpFBe7h4wsjgdXozB8SthHF7jmxDlnQ1RXvstLP5D30ddnNHE5qlKGz3FzchnyeRdHQcT+LbCtLoQujc1KLIfvxEoV/BfyGKUYrcvyZf0ekca+G3sV1D9BQbW5Z6bmqk4uP1qubOyW9V7lhphVFbWd1jjyfXb2dyUf6E6WOjtgAwjZ9lSH7VDz51rML6yGdLGcd+SNVrtVJTJ0j6SmUrgBA04eqpELiXCmduesITJVaI4a3e7IDpKexuzEPEB9/rbGDGvTMtrsn+vO/N0jJI+CaD8q6cg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(1076003)(54906003)(6916009)(966005)(8676002)(86362001)(4326008)(6486002)(316002)(66946007)(66556008)(66476007)(478600001)(5660300002)(7416002)(41300700001)(8936002)(6666004)(38100700002)(6506007)(2906002)(52116002)(53546011)(83380400001)(9686003)(6512007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9WPx7kD3cZQB4BL1k59zcR8DCrgihQSlIcvyjsILvfJpB51rLxVgOaOkqwmL?=
 =?us-ascii?Q?XfCGAmt3cbkg4Xot4WAVmFbwP5bku8Z+oquj0M4Njc8chua/IpyCBeiQ6yNR?=
 =?us-ascii?Q?HPdjCndfeoQC0WRuqwvArSivNTaZWAxSmPDnNK+Q7vROokSW3Wuy4y5nR1jc?=
 =?us-ascii?Q?Bj5iU9znIjQoQFuyOcBll4UaFlhASFYayq8Iz+3azzSyTw2IIMl4AxlBgTGy?=
 =?us-ascii?Q?Vzg83oaOR3bSges6UwLuTSEM9rBhplPKD6qb6DW01n6rrkIoOHJPJkkpdOJM?=
 =?us-ascii?Q?QK8CAuoJvSDtT9/7UPkM3F8hzjjBhTB8ZFsVvoPh6/LulX1lV6nBNKE6zpMt?=
 =?us-ascii?Q?Yr3li5m3g5/Y8hGTyk2ilhpPrlCJOvD35y1Wkk3pqmo+6I2VgHjb1xdq634n?=
 =?us-ascii?Q?kmhiYvQl0RZmPr/e7P9Vw18VFdGlYTdU+qw84T3Qhtvrksm+mnAcltcVCJoT?=
 =?us-ascii?Q?oO2mBCmjRMj7nShfD6HcKlAZpfK77P+dQTXTIJLjks/y3B3nWhsN6hTBqxj9?=
 =?us-ascii?Q?ZVZr8TgfxZFo5ugVTahqSjypkx38C8cVpIxvSxUI59rH6bTDKZqKUfa51CKc?=
 =?us-ascii?Q?wkm9OiRnKj9tgRHmqcNkTqfxWQ3AatpVp+OPMVX29JLX2LWNsPqjnrWGKn+t?=
 =?us-ascii?Q?td7H3vuiGhMUpea1JieI1GD7JgLAE4wi+uGt52ICLM015/EhR43ur1kSc6ls?=
 =?us-ascii?Q?UlRK1h4uMeQSfflnVm3I2ptxomdRqJNBBfPWMgYBALaHueFr/EzACiz76/og?=
 =?us-ascii?Q?+PucWRD+uNtpYnKzoKuuQGtcKvjZfMxmtekGmnRcHmg6VXtac6badwOQpfFP?=
 =?us-ascii?Q?rXAGFN0pkOdFIQUJpNYU7hiqP02ikbXuMj87cVm2Kfbr2CQ9a1JZF6xNfeFI?=
 =?us-ascii?Q?BbQ3gZXvUO3YzuPlBMNSsf1LOR84+LetIe4P41p14fmNyfFLEESFZU1fF0aY?=
 =?us-ascii?Q?x3FpOPEOr5nYZY4fPKSuq2NKdmnkvuEgmXlgh6WBbVGtqoGNQpJxQSdqq4tx?=
 =?us-ascii?Q?OcLhHxvE7u0wOkS5JRPIKaVPg7jPy/hcF8ygAdTNSaVfahSFPFF/kKC1yb7u?=
 =?us-ascii?Q?uzQh1QsiGiWdFpFFMU4ci1b5+8E1ixszg8HB/0tSotdaPjsJNNApQ5Nmkx5F?=
 =?us-ascii?Q?yQEnqZRMxgCE1oeWSlHkyi37OYt9c904f9SABX7BE3ncVbiwRplDBZJP1WHN?=
 =?us-ascii?Q?mJZlkHjaBLmMIeHRiG/3/tJG0PJ8bA1vdT1h1xNn/xMuHbsOji6TeuX2zj73?=
 =?us-ascii?Q?459+2govsNyDQfVuU+FnCzBJ5n+VrDWAUCiLB1mQsaiQEXkaQ0pZk1cKn781?=
 =?us-ascii?Q?P4NTSt2mGrpAiNbQjUQbEmmDB4g4AXR2uskq2B+hi+77c4Sp7YJqEf/B6Jb5?=
 =?us-ascii?Q?EF2gL5d+SdIFAxb4zu5MfVkMTBWkFp5zmstMI9kTgJNhbH790HoMqJLDa8ow?=
 =?us-ascii?Q?Z+YAJN6tAJszfWnaCqmmmhuBW1Qfth1f5uVR2hUVY7b5yQWFBKRFR28hOrug?=
 =?us-ascii?Q?N7EU5UL7iKKkia4Z4kysErCFFNWdcWG7gI9DeibuYa/WIPeM77TZUYFnEjxX?=
 =?us-ascii?Q?fejh0mcgPiJECBI44gWue/lzoJjSBYAzDTaTh+xhxJw/ZvcEODE7FJT9mHN9?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e53f64f-d5d1-4a13-5885-08da89e8c7c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 18:03:30.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErQjtR3WSWFz4g9Z3VojvYgzpCvCglM0sJjdYhxsJFqSivEP3JXnQ5K5l3b88el3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5380
X-Proofpoint-GUID: TTNMqVmbn1tiWFhijKy1PYAPtEU4ofVZ
X-Proofpoint-ORIG-GUID: TTNMqVmbn1tiWFhijKy1PYAPtEU4ofVZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_09,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 27, 2022 at 05:38:29AM -0600, James Hilliard wrote:
> On Fri, Aug 26, 2022 at 5:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 11:29:22PM -0600, James Hilliard wrote:
> > > There is a potential for us to hit a type conflict when including
> > > netinet/tcp.h with sys/socket.h, we can remove these as they are not
> > > actually needed.
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
> > > Changes v1 -> v2:
> > >   - just remove netinet/tcp.h and sys/socket.h
> > > ---
> > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 2 --
> > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 2 --
> > >  2 files changed, 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > index 474c6a62078a..a487f60b73ac 100644
> > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> > > @@ -6,8 +6,6 @@
> > >  #include <linux/bpf.h>
> > >  #include <linux/in.h>
> > >  #include <linux/in6.h>
> > > -#include <sys/socket.h>
> > > -#include <netinet/tcp.h>
> > >  #include <linux/if.h>
> > Are the AF_INET and SOCK_STREAM coming from linux/if.h somehow
> > and they are not from indirectly including sys/socket.h ?
> 
> Hmm, seems they are both coming from sys/socket.h:
> 
> Tests with my v2 patch applied:
> progs/bind4_prog.c:15: error: "AF_INET" redefined [-Werror]
>    15 | #define AF_INET nonsense
>       |
> In file included from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from /usr/include/linux/if.h:28,
>                  from progs/bind4_prog.c:9:
> /usr/include/x86_64-linux-gnu/bits/socket.h:97: note: this is the
> location of the previous definition
>    97 | #define AF_INET         PF_INET
>       |
> 
> progs/bind4_prog.c:15: error: "SOCK_STREAM" redefined [-Werror]
>    15 | #define SOCK_STREAM nonsense
>       |
> In file included from /usr/include/x86_64-linux-gnu/bits/socket.h:38,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from /usr/include/linux/if.h:28,
>                  from progs/bind4_prog.c:9:
> /usr/include/x86_64-linux-gnu/bits/socket_type.h:28: note: this is the
> location of the previous definition
>    28 | #define SOCK_STREAM SOCK_STREAM
>       |
> 
> So I guess the problematic header is netinet/tcp.h and sys/socket.h is
> just a redundant include?
> 
> Removing just netinet/tcp.h does appear sufficient to fix the issue.
Yeah, it is what I am puzzled and getting at.
<sys/socket.h> is fine and <netinet/tcp.h> is not ok.
They are both from glibc ?  This kind of header changes
is hard to reason without doing the kind of experiment
that you just did.

> 
> >
> > If the program does not need if.h, what should it use ?
> > There are other progs in selftest/bpf that include sys/socket.h
> > and they have no issue ?
> 
> I'm still working through gcc issues with the test suite so there's
> probably some cases I haven't identified yet but this is the only one
> that seemed to need any code changes when removing those 2
> headers that I've found so far:
> https://lore.kernel.org/bpf/20220826055025.1018491-1-james.hilliard1@gmail.com/
