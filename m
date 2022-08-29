Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338545A5387
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiH2Rym (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiH2Ryl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 13:54:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965367DF63;
        Mon, 29 Aug 2022 10:54:40 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27THg77d025816;
        Mon, 29 Aug 2022 10:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/pdVDPhY96mMMN97cGa+Y4Pf8LI/M4/5VbwGCG8qeGU=;
 b=gE2GtaHC+QTCygm3o9GMVtanP7L09xP10g9/iaSDHzp2dWWeyWYgXGuCWvyAqutdE+An
 vBLmqR1KWvPJ+DjTNVsUGbM/zgQFxBMeA5xiDTHN1ISLe+hzSkOU67E42KXsy98IM+ig
 qq6LKQCXtUHutZRBGODWq273zoQalUa0p58= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7ekn3khk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 10:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvDLDxAD6GZwCo5lsjyHoB6CEaLNAR9mucoEVwk+YtHMDJIEjwq06mQZsFQW7gsYEdB92MXYmu2YpL26bMcjju6FuU142jkDNBF0lVLiwthBjmL+upBXXYVJ/KgMUa48OHmWkgyUD/Qb3OS4tdO01tDaPVpnTh0qd/lu/KITJkX8v0F05asXtv+a9+yFIrM6VeG4HXYOq9La1KwLQn3VOD1FDysdDb5xd8UGLE/lkMQMHtqs/SqYIZFM7AWwMpzM6s9fy9ei07OQUwlyg6vsVbGaCfuxNLoD3jdtnij5blIDtDf2GY4gqV4+AEyONqC50aogmlp+bDvkrbt2DeHwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pdVDPhY96mMMN97cGa+Y4Pf8LI/M4/5VbwGCG8qeGU=;
 b=b8qOCJV+0L8h4Un8W1JpJ0i0EiZsTiPpHDB2mpHi5006vw7s135l4YUJav8cehyIqWGyYPsuFCJGiuR6Mcw0BU+lA23zHFH0hzmdHYwqGsZ8uwFYM3foUMNGmpF1IYAP1PwnJmJD7UwK4k5Ll5nS0uOj2cw5Vf+1LF/08Bjqi7WMh1Ydi2r6MPGbo6O3YkUszhaNXue5+PAx2jxD3PXz2LMtTxxnfqx0CTzESGvi6NBfBzcd6HfYajDM4ZAYEr428fs8oBybf0pssHmxjmuvqNUubJ4hHKcV2mPKllsEAOatHvOl9yv60Xx3LmayoG2dFYthre9sb2i6bjOVsxzLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB2730.namprd15.prod.outlook.com (2603:10b6:5:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 17:54:17 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:54:17 +0000
Date:   Mon, 29 Aug 2022 10:54:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
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
Message-ID: <20220829175413.h2335oivqcg34pw3@kafai-mbp.dhcp.thefacebook.com>
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
 <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
 <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
 <20220826171741.pdiqa4n4mls56bw3@kafai-mbp.dhcp.thefacebook.com>
 <CADvTj4qg6R9udazmGFoFhn9pXN6HOqLGEsQOhCAELi1LxzoTmw@mail.gmail.com>
 <20220826212550.mgugz6fomoqpgdbb@kafai-mbp.dhcp.thefacebook.com>
 <87k06ubi9m.fsf@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k06ubi9m.fsf@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3edeb90-0c8b-400d-e8d7-08da89e77dd8
X-MS-TrafficTypeDiagnostic: DM6PR15MB2730:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGk3Qrk1/WpDHgQTc1XB9tuiuiIQHYZXLLsLV2jZPnVmTjxCZVS4Jv9nDj5QNo3Paz52C2i0fbb7mWwWyaJ7flfus3HhhY00Opoqbrhlxk4iBancjT/4sgj9YmGqUGCbqoQKaofNZXeGZM/Lg15cjO+LGNnaiGXggSshUJXjuozHB0sqSz8YqKgQoCwGNQGgGwO02QJZ/bIK+JjikNzRMWvidJcXzTujWIcxzztMF7Qyn8HeopkgVK9w+xnv0B0/ZFRzJCTcufa5gvt7v1JZ+dpssIyOrn5YtmZ12mzqlO0A2+l4QItzelQAgNia5hmxY57PUz98KBmBadk/P/jnyO1nCKEH/iRztDt7fqjl/xeyz/hg7gfqP6IcPH3KMwALoHrhuwWHs1BCcnuYZ+7aJeE2/ZkPl0CRozcb7btZYxkYlHLUwKtEdZNnJeezFqksTZimL36rZ37dOyJ99WNppflwCuZwq+yFWnIcNnWpcqbbLW0qFIQX2vSCl8Xp+fDoV/K3SOnPUmrECD5TOzOsz1uOPf/fbs/zD6/rQpTu0rtaO49ulQJavF5T8mPZrHYHv4oJWEohAcHOVADexHzWFNKCXwlaeblSe9wYUfaBAUdFHqaTHeoB+XpdDEXg3/pPFVUSW6IFV35JHyCyIKlPmHErTICPmLChI9oMmK07BmFOo9qc4rfwDJ/nqNjBQAg59eO0Yt6LGWAfIyDyoBA83A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(54906003)(2906002)(66476007)(6486002)(8676002)(6506007)(52116002)(66556008)(66946007)(1076003)(83380400001)(6916009)(4326008)(186003)(316002)(38100700002)(6512007)(5660300002)(9686003)(86362001)(8936002)(478600001)(41300700001)(7416002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xp+QCuOoWyw3bZWMRn0ECqqI+s7cOQebx1Zrjl1orWnS8e+zVmQfGVMb2tt2?=
 =?us-ascii?Q?buxxgZkhff1+Gxg6sIVIuCd8WootHL9tIgmnPWROh9EOormMXPVIBYCagsJP?=
 =?us-ascii?Q?SIiIeQWY1HHGcjzsECL5M7bETwuaMDqFU0Hhl9cijaiK7sODgH1Y7ReN10Cu?=
 =?us-ascii?Q?QEFL+aMf7Gp6uVtVC+3kQTn2lpTmmg7JtI84fjlqvJLqjQERC3TKoCKvPFvD?=
 =?us-ascii?Q?shB8n2uJjgDxcS0PEkOgI8jxEzq8kAyHozf8cU0qekmu0W/9z3ydn//bg0Yd?=
 =?us-ascii?Q?BElz9eyH5txQmH4ddOX4jZFlLo5cRKt5lHBKATCsiUB2WIplwroYoEm+eXV8?=
 =?us-ascii?Q?tEr9Ih69zJfU8V1qKKuVcPgfsu+zgytKC9m3+Sg+CgsivHrdT+ecn9fv8jpN?=
 =?us-ascii?Q?GMfVSHkK0Scmfx2sq08vwO0iSmklO0mnsDvlFJDANDnlxc6nHFK1y1vLqWld?=
 =?us-ascii?Q?E/2r/ROH1sFdXPmkF8OPYWOqXgZwFPqaJRicEXqeiIlYDYo3xqH7BU3BNTvD?=
 =?us-ascii?Q?HpPMDPkNPyrCtDqhIEaZ+1RjtbvXDbiylCHOD2K+BppDN8pHjewBO6ypiLgm?=
 =?us-ascii?Q?8piWtHAz79xxVZocNRoQFYuGZX3dSjmvWqtFxRBy43Te4hZilb+QB3neh3Jb?=
 =?us-ascii?Q?DvCT8s609X/JUCuh0xiAYlDPmla4GL15dEcVJ0r2z2dggUymMXoWxLs4Krc4?=
 =?us-ascii?Q?E7ijIIXU+IFieaZrfqxg7lLo0KjwHhWJJXaBBil0x4WwAShCalUK6DBKxbgB?=
 =?us-ascii?Q?JOFPClPdKZ0/rKoc0XDbvinK3ME7nqZnEGzxbsMgxvuicLpikBVmIHM7ZZXG?=
 =?us-ascii?Q?ix15r6lW+2rMGxw6KAzMP0CVm3nmaRPSA94t83agpf8BfkN7XnXsc4bblHqw?=
 =?us-ascii?Q?jbSsRS4ip1A+JnnTh/sjemhmnug9i+yyzsgk8xt7F9IZLm9yIMK0JT7AY2xq?=
 =?us-ascii?Q?VbD77ro7n1z9ynV0c+yuTAg9BD2/VmrlPYVN9ZlQ7PUC309nEir9yLUUJemQ?=
 =?us-ascii?Q?mpEvOrcdVig33rvvEXNs3dRIEV+qo7oYpUsnHsAL84+nL2T+Jdx6LKVf9bkd?=
 =?us-ascii?Q?+YGB28/xmRFYWi2xgQbrPxpwv7NsiTN8ElXVwcD946CE0CrA5JmqqUzzJPfc?=
 =?us-ascii?Q?DnpoOTTPX8I1u13UUXAXrNQ/wVrlX59+pWeYXTt7ou+hIRysotLqJZ7vPOEB?=
 =?us-ascii?Q?Wr0lglJ2EvGzvC/xwbr9C1rmX3zfAkou8G278W+2IKpT7bfBlRrkkyKtcO69?=
 =?us-ascii?Q?LWpId+sD8RrE0ZpPo9rxmSlFCTTo98Y9uU/BI5OIspxX8m5QrncZIFQCnguQ?=
 =?us-ascii?Q?HLdDrznphGbDCTuRGUMvujiZfNsXSu1esfYR2ea3wZYChHxwvuqEK8IOeXfN?=
 =?us-ascii?Q?jvA5V4J257ZBxMUZYoSjeDsPbmySWgGCFkmj6s1e3WUBGY3oVhCW0k69d8U1?=
 =?us-ascii?Q?Ac6xpXUG5+Mp3iZX5h+pZutWM9k15+ElyXZ8hyjy3QpKI3qsMAY2LVeoH87h?=
 =?us-ascii?Q?ljjc9lPwalznkToVAQlznlC2xlqZhezsACxnsef7hjKQKrOviIU/IFATZVCR?=
 =?us-ascii?Q?bpLo2YIlQWpuBiyIQjBieh/R3w4UFHbb3Hsgs+5hQKd1bSPr784bZ/UG0pOt?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3edeb90-0c8b-400d-e8d7-08da89e77dd8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 17:54:17.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnuDIdlNjYtUfn/7MG37Tb62Ru0tFMMS5wHbbxe2fBsmAdOV+igvJaM1i4G60SQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2730
X-Proofpoint-ORIG-GUID: f8JOkGPfsmNU8oFMGHoBKTuMKkhX2J8i
X-Proofpoint-GUID: f8JOkGPfsmNU8oFMGHoBKTuMKkhX2J8i
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

On Sat, Aug 27, 2022 at 03:13:41AM +0200, Jose E. Marchesi wrote:
> >> Users can migrate away from libc headers over time, migrating away
> > imo, not without a good reason.
> 
> Something that may be a good reason is that there is no BPF port of
> glibc (nor of musl, nor of newlib.)  And given BPF's restrictions as an
> architecture (no more than 5 arguments supported in function calls, etc)
> it is very unlikely that there will ever be one.
> 
> Including certain libc headers may work well enough, but in general when
> including libc headers you risk dragging in x86, or aarch64, or whatever
> architecture-specific headers as well, directly or indirectly.  C
> libraries (and system libraries in general) are targetted at particular
> architectures/ABIs/OSes.
> 
> This means that the same BPF program may be using different data
> structures depending on the system where you build it.
Note that the data structure difference is not unique to
different arch.  A more common case can already happen across
different kernel versions or different kconfig of the same arch.
BPF CO-RE is there to handle this case.

> In the worst
> case, it may choke on assembler snippets.
> 
> Thats why the GCC port offers certain headers to provide standard C,
> like stdint.h.  That's the usual way to go for bare-metal targets where
> no libc is available.
> 
> Again, we will be happy to change that if that's what you want.  In that
> case, it will be up to the user to provide the standard definitions, be
> it by including glibc headers targetted at some other architecture, or
> by some other mean.  Not that I would personally recommend that, but it
> is up to you.
Not sure if the user can always stay with vmlinux.h + a few bpf_tracing_*.h
and if that is enough to avoid knowing this difference between GCC
and LLVM bpf on libc-vs-gcc stdint...etc.

The header changes is hard to swim through to make it compile
in GCC BPF.  In this case, it is because netinet/tcp.h brought in a
different int8_t from gcc than the sys/socket.h.  My preference is
not to have to dive into this kind of header details.
I would like to hear how others think about it.

> >
> >> shouldn't cause regressions and should improve reliability.
> > May be I am missing something.  I also don't understand the reliability
> > part.
> >
> > In this sys/socket.h as an example, what is wrong in using
> > "'int8_t' {aka 'signed char'}" from libc and the one from
> > gcc "'int8_t'; have 'char'" must be used instead.
> >
> > Why LLVM bpf does not have issue ?
> >
> >> 
> >> > The solution should be on the GCC-BPF side instead of changing
> >> > all bpf progs.
> >> 
> >> I mean, GCC doesn't really control which libc is available, it seems to
> >> be a bad idea to use libc headers in general as they are developed
> >> separately from GCC and the kernel/libbpf.
> >> 
> >> I'm not really sure how one would fix this on the GCC-BPF side without
> >> introducing more potential header conflicts.
