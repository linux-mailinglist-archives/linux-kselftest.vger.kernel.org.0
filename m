Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30D4318F09
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBKPnz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 10:43:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52640 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBKPlm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 10:41:42 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BFYFu2027160;
        Thu, 11 Feb 2021 15:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=OsWP/PV1vYOJJUYozb5M654ZyDpu0wKy+aGoFSwCIIQ=;
 b=FKm7hD2lXm9lAXVyBUlL3gUl7EI8einqpav83MzBYxN3ty5rxBPTOdZn4QlBfE+NQV6i
 fFGK8K8tgX2MRDkNnMGxdJ4f9rl0nqIJaSEfMJEbJyO2b5WOmP5TEe6Oq2h0KJv/Ql7S
 1onlEe0PgaFIaq3WUO/hiD2V+z+fjkISmMFGNTbubNwzJNmd8m6/WwiUQy8/o85HBwWi
 HjVS8Ox5iWgih+KanUdDSJxC2zJHkwsqKMnnjy7kBAGjx3URfyfwrDT/hgb3mh0qlmXh
 bdoC5X3yDsSChvIE8ijmyL9Vf/Qm/Mpa8VAfkj8jjP/sHGlwReUTmWh3IPmU5OESoweB aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmar300-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 15:40:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BFZo6K129370;
        Thu, 11 Feb 2021 15:40:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by aserp3020.oracle.com with ESMTP id 36j5147bvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 15:40:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBWBn51Eh5cWbtuxSXfDReCwRd7unmCvN886SfoASJILH4MUzxtv2OvvVvyRujGBSuWXa7+aKhv6fjRSHt+LpKZ3uj2BLWMFfj+258rMt5NcL/WNffFBZBuOQGJVixknxvxG39IROcrA7njeqRH7SEh4ljDfJDWLtWbeSKxor44vk0VMEFtM5NEEeeM+lzwfCTNRnlKdNGkHHNgh82B0uNdQD8faPQje/MqV++lcNHMjGRFCjenldUSW4Tnkyc++VSz7M6rW+76Xbz1Cb81j29sB5HV3AtR+477h8tlYqbHJ1kkw/Qn5Rxp3SY4pQj2VCgXkBmoLCaVDpDfkzcYfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsWP/PV1vYOJJUYozb5M654ZyDpu0wKy+aGoFSwCIIQ=;
 b=KmqgOn4+yQ+ToEGrArRLVC0GgYzx8Y/zu0YhiTOtT6Pw4JbDtO28uGecb5t30MaK8iadvyy78dqFlly7PGewkSPj0GcFun2cfynTrBfqJUGRkQW1WwVnDLoxkliOYpOGoAXKWZPWnNOdtTC9f5Mk8RD7/UXZelvnCPXT1Ym+ncMTNdKFFpicN3l38vzBLhPI/FvvLXjhcWEQ/RE3NjexsomPkaDVX7xItSJEoESRqR5rfzhBe40wh3GeKeOXN9aKTZ0OTqUyYlCh+Frbw9r9ks4n28Htwu9fxHreQsGdlESx0yYboOBfThPj3h7LSvYU7Z1VBPnGsN9vQZwJRyL3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsWP/PV1vYOJJUYozb5M654ZyDpu0wKy+aGoFSwCIIQ=;
 b=GJPGRZPeKejgihsSUJAarFsBBJm0b+DytrekeF32Ai99QGzce3Ax9werARpfWO6fQY545JafxPqji58BnpNe3y2jMCLCFRjcudAO6kLwF1htnbL6QxJb51wZiagYa4TVZGMR1bVdTU6YZR5uBgI74+uJoJKDyCJ0nwPrXR434Lk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19)
 by CO1PR10MB4420.namprd10.prod.outlook.com (2603:10b6:303:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 11 Feb
 2021 15:40:47 +0000
Received: from CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714]) by CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 15:40:47 +0000
Date:   Thu, 11 Feb 2021 15:40:27 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Subject: Re: [PATCH v3 1/2] kunit: support failure from dynamic analysis
 tools
In-Reply-To: <CABVgOS=j=23J55jqT=84AhzvBxwZSR-POMOndZxAo1JCyvBLtA@mail.gmail.com>
Message-ID: <alpine.LRH.2.23.451.2102111524210.10553@localhost>
References: <20210209221443.78812-1-dlatypov@google.com> <20210209221443.78812-2-dlatypov@google.com> <CABVgOS=j=23J55jqT=84AhzvBxwZSR-POMOndZxAo1JCyvBLtA@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
X-Originating-IP: [2a02:6900:8208:1848::16ae]
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To CO1PR10MB4516.namprd10.prod.outlook.com
 (2603:10b6:303:6e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 15:40:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ca991e5-55dd-4cf1-002d-08d8cea366aa
X-MS-TrafficTypeDiagnostic: CO1PR10MB4420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB442079EA59A87E31DF6AF636EF8C9@CO1PR10MB4420.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:336;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3rnGbQ7UQ33j/GwLYow0JAYJummipHwRzqG5YAS/EHIxSNGBK1Awa4U/FBfW6Ei5VnHdSxGASB6Mh8xmyYXNQlFSW69x4n8PgzBuwtVYqmCKSI74VDUKD3OW7fXehKviyPrGTkd6QyNRTKjqpQngfNlibQ2BIb+XSvxip5bT38YoTxfyuHx+xak0bWI/bCQWZuav4BW+xPU7z7qQpeze3vzdn1IV+1EGyklqMSWjH4ExqOPV9vQiaLViVlbXdBAesHX42fJ8SDauCf8M6HbEN+PJt3N6P5bqTcansCl79vBGQ6pDkdgqXKn0H/a87qpBED5dz57FTBbBWVZYYYpA0kPLdF7RC+2ihWcWYwKP2HUXPsW7A98yCyQ5YArTA7wf4YvJQYV+iEZBF7ccjFvhk55kiaGrBKaV9uSjCCYc8qBihYDv2mhUyFWIru7kvC4V6GYi5DezvJWHT7teXddKrLI5dRp+CJXUEyO7/rIS9qPQGnflRhSxHTCmIiGvu0V+tDowAlqLpwGE74wCt25hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4516.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(4326008)(478600001)(16526019)(2906002)(6916009)(83380400001)(316002)(52116002)(6666004)(66556008)(53546011)(186003)(6512007)(9686003)(54906003)(66946007)(44832011)(5660300002)(86362001)(9576002)(6486002)(6506007)(33716001)(8936002)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pKntQ4kF+92F4CGF403J3/KgxsKvMHFR5xh0NBgK/fz5UmQQjd7Mu1SpzTog?=
 =?us-ascii?Q?paEzIj6aQNEKrFWZADXQrqDJbN4wj238b/ybAJ6Swr13ddpQRJA8YpNDAo66?=
 =?us-ascii?Q?EuGbq2fe+i6t58zf+yy6RnVKSfesyKvbezP5R4gHTUkPK5GVG9jicplptTyt?=
 =?us-ascii?Q?TuLr8A1T5aXNrKfw4YMGOSB2BnAWSML7QNh++arXsWQAHYqaA/SKHwOQ2Rr0?=
 =?us-ascii?Q?elPF2bV+/pmaGdgnSV+slDyJt/HkFIh4y3mfk8lAPxQii8PFafArRNN7FLme?=
 =?us-ascii?Q?fPac4x84awiocnDDq3FCurmBNRE9M0O7huOKH5/IKrVGHIKFw9YifSleZ55y?=
 =?us-ascii?Q?W4imRzQCURhR8VQ3bdqiHBBqsKw0RfXQHHKZug8tk0fDFmHdwvAnxdMeEHBZ?=
 =?us-ascii?Q?+dn5nTgvymmdNR/xHZuOOUTnSM0r/RXz2e2lQq+iiMeZLhGLbEKYUFf07D/X?=
 =?us-ascii?Q?i3InNxGsRZ9hljGeChveTOREesGJoDMwBOSc7DL91u2LiUnV1TC521cONVf/?=
 =?us-ascii?Q?Znsg2ul4e7QqcL1jFdZgMwubhaphjs6Dfl2T6E+Dq4J3dc03JEqPMp4/JUL7?=
 =?us-ascii?Q?OJy9WRloELj63lAI+dNR9ZwcIBaPLzCftoKe37R7UucMk5apgCgz/5cLI5oz?=
 =?us-ascii?Q?6WH2vGeAY9jq5WAI443ZeXbxwu8/akF83tWFbuWQT8aEZQUExv8oZ63GxliX?=
 =?us-ascii?Q?NULR7II4O7Q2ZNLAh6wc6EIhOUsUlpmJSYJJKCJezog0ey+vqNvo9sEg8ViW?=
 =?us-ascii?Q?FT0JsuFXkBIzCpZTEOHSMnMOAIdORlgTgxFv70zaqsTmbe631jYoYvVNP7rI?=
 =?us-ascii?Q?I+BJWROhsPD+kgybsg4ieM+Gp+PyGFp055igKkBc5OArRLt4O7RMB59r3+NZ?=
 =?us-ascii?Q?PbIIwzvAzbvNse5sqM+TVLRFBTL6yb0aRE3mkTUvoBcdzqKpSi+j0Dvkbxu9?=
 =?us-ascii?Q?UrhvdQS3d8H57PfKs8YC+xOdf9r5wx9d3YK71s3k+B0qz9AyEjE2VokbrC10?=
 =?us-ascii?Q?zWj9k77RSvhPdKR9b+pmd/kLuDTlM73DdVcHVt9vEjcYjLMbh7eiCgkiZuhS?=
 =?us-ascii?Q?R9DrvjMxF0fTxfrFDLugguE5HU5lqI7z2X4Bv6uiGpkVFi97MWExBILWXbha?=
 =?us-ascii?Q?qwDqTccJijsqtqGWXPuA6m816l7Z3M1CgAMgDK5+Wzkt/i0W/krSY5eI5mWM?=
 =?us-ascii?Q?LAjInxjl4+qV7WJUXOrd1f4CBye/EBdyKjSGwc0YZcqiveCxBX8BznbUuXmD?=
 =?us-ascii?Q?9pw1k8UBI6dvZ5K3y6RIxD4tfPyoMI0nkGucCbMSNH7RSETdRJkY8hwPoN0e?=
 =?us-ascii?Q?MD2D0zScIyktqIkMnHMmzW0AA93deznUxoesUaIQS7Om7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca991e5-55dd-4cf1-002d-08d8cea366aa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4516.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 15:40:47.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPHTEVeBZQNdNKI/AObKLvzjlxP7RLo7kl8D+Y1eqXq9HPk8FVbSa9p0jJ06pLW4Yc39lNiNALU1EAtaSgolxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4420
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110134
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 11 Feb 2021, David Gow wrote:

> On Wed, Feb 10, 2021 at 6:14 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > From: Uriel Guajardo <urielguajardo@google.com>
> >
> > Add a kunit_fail_current_test() function to fail the currently running
> > test, if any, with an error message.
> >
> > This is largely intended for dynamic analysis tools like UBSAN and for
> > fakes.
> > E.g. say I had a fake ops struct for testing and I wanted my `free`
> > function to complain if it was called with an invalid argument, or
> > caught a double-free. Most return void and have no normal means of
> > signalling failure (e.g. super_operations, iommu_ops, etc.).
> >
> > Key points:
> > * Always update current->kunit_test so anyone can use it.
> >   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
> >   CONFIG_KASAN=y
> >
> > * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> > to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> >
> > * Forward the file and line number to make it easier to track down
> > failures
> >
> > * Declare the helper function for nice __printf() warnings about mismatched
> > format strings even when KUnit is not enabled.
> >
> > Example output from kunit_fail_current_test("message"):
> > [15:19:34] [FAILED] example_simple_test
> > [15:19:34]     # example_simple_test: initializing
> > [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> > [15:19:34]     not ok 1 - example_simple_test
> >
> > Co-developed-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
> >  lib/kunit/test.c         | 37 +++++++++++++++++++++++++++++++++----
> >  2 files changed, 63 insertions(+), 4 deletions(-)
> >  create mode 100644 include/kunit/test-bug.h
> >
> > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > new file mode 100644
> > index 000000000000..18b1034ec43a
> > --- /dev/null
> > +++ b/include/kunit/test-bug.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> > + *
> > + * Copyright (C) 2020, Google LLC.
> > + * Author: Uriel Guajardo <urielguajardo@google.com>
> > + */
> > +
> > +#ifndef _KUNIT_TEST_BUG_H
> > +#define _KUNIT_TEST_BUG_H
> > +
> > +#define kunit_fail_current_test(fmt, ...) \
> > +       __kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> > +
> > +#if IS_ENABLED(CONFIG_KUNIT)
> 
> As the kernel test robot has pointed out on the second patch, this
> probably should be IS_BUILTIN(), otherwise this won't build if KUnit
> is a module, and the code calling it isn't.
> 
> This does mean that things like UBSAN integration won't work if KUnit
> is a module, which is a shame.
> 
> (It's worth noting that the KASAN integration worked around this by
> only calling inline functions, which would therefore be built-in even
> if the rest of KUnit was built as a module. I don't think it's quite
> as convenient to do that here, though.)
>

Right, static inline'ing __kunit_fail_current_test() seems problematic
because it calls other exported functions; more below.... 

> > +
> > +extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> > +                                                   const char *fmt, ...);
> > +
> > +#else
> > +
> > +static __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
> > +                                                   const char *fmt, ...)
> > +{
> > +}
> > +
> > +#endif
> > +
> > +
> > +#endif /* _KUNIT_TEST_BUG_H */
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index ec9494e914ef..5794059505cf 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <kunit/test.h>
> > +#include <kunit/test-bug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kref.h>
> >  #include <linux/sched/debug.h>
> > @@ -16,6 +17,38 @@
> >  #include "string-stream.h"
> >  #include "try-catch-impl.h"
> >
> > +/*
> > + * Fail the current test and print an error message to the log.
> > + */
> > +void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> > +{
> > +       va_list args;
> > +       int len;
> > +       char *buffer;
> > +
> > +       if (!current->kunit_test)
> > +               return;
> > +
> > +       kunit_set_failure(current->kunit_test);
> > +

currently kunit_set_failure() is static, but it could be inlined I
suspect.

> > +       /* kunit_err() only accepts literals, so evaluate the args first. */
> > +       va_start(args, fmt);
> > +       len = vsnprintf(NULL, 0, fmt, args) + 1;
> > +       va_end(args);
> > +
> > +       buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);

kunit_kmalloc()/kunit_kfree() are exported also, but we could probably
dodge allocation with a static buffer.  In fact since we end up
using an on-stack buffer for logging in kunit_log_append(), it might make 
sense to #define __kunit_fail_current_test() instead, i.e.

#define __kunit_fail_current_test(file, line, fmt, ...)		\
	do {							\
		kunit_set_failure(current->kunit_test); 	\
		kunit_err(current->kunit_test, "%s:%d: " fmt,	\
			  ##__VA_ARGS__);			\
	} while (0)

> > +       if (!buffer)
> > +               return;
> > +
> > +       va_start(args, fmt);
> > +       vsnprintf(buffer, len, fmt, args);
> > +       va_end(args);
> > +
> > +       kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);

To get kunit_err() to work, we'd need to "static inline" 
kunit_log_append().  It's not a trivial function, but on the plus
side it doesn't call any other exported kunit functions AFAICT.

So while any of the above suggestions aren't intended to block
Daniel's work, does the above seem reasonable for a follow-up
series to get UBSAN working with module-based KUnit? Thanks!

Alan
