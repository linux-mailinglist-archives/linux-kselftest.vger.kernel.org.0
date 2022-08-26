Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E25A2042
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiHZFRD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244860AbiHZFQz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:16:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFB81B11;
        Thu, 25 Aug 2022 22:16:53 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27PM4JhT024864;
        Thu, 25 Aug 2022 22:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=3vtEMNJCkNeSbLAXvhjQ1DBf8aS8b7Jsbcwg6K5pBCY=;
 b=lRmC88Kw64iV044a0lWw4+yyCaYb1TUmFqslAxVYDy7bAQx+bqSyylHCKhUPa91rVmyt
 5qHeEBoSit2OLcbZTAhTMTtUexFf3BE+5etr0GBbEN1nmpOuzY+vSHgHviV3DEETu8L9
 PgAhMEKOHAJtgnNeHRMWWx7wSbH6vfN0Xfg= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j5xcgs27r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 22:16:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAeKeRHxqfMfvtf5/oNAa4OEPDqympXCYUZQPmfXDolRDtn6vKxwzhfsTUk8ClBBL9DWPeKt2o3/EMSOV7Rdv7L7Pk5xWM/2Ij55FTL6bShNeYfvExfHapfr6wzoDFx4MtZ4gvYrdzy7alen9al0e4PoudKwfl5HotTdKltDMCLXIIxjbRNkxNhalqTjv2TWy9cZ5aCacc6st/0L5Da5Xx4ZHFYgZxNaL3SWKHYyWn/aIrNStsSEvRPz9ft+UKpFHxpRECks3EKvIj+eSZsSSQcxBqLW7/651Jg5g2hR1uIOkhi1b33cs8XhR07M5WO4SqFn0w35VQhiJvlJMpuJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vtEMNJCkNeSbLAXvhjQ1DBf8aS8b7Jsbcwg6K5pBCY=;
 b=fZVAJAtqmQh8Oeq45t78XDPfyOmtogVSTO7yzamo56F2q7fwvHGa3KToUg3GojDzxSX+V408N235tjVkHYx2iINC+OzdSkjXMbdTIOFKiABiaPMK/oayHfpCFNXUJqECjDKldcgbEOINyUyiCHFiiC5JsVvM96MzASS2m8SQRDaoFibrRM9S+mGxQWgGcaTarCKrUynm437KmXq/5QOM/XCiuvlG99JBL5t5wap5c5C2HjINrw8tX/ZO5ExXiYIWnjUiu6p6VnQbIRLo4At5YmKP4KFlpkQVKQn1oiA4aRR4+cKnMxq2cShSjM7Byoce0uZnAG7sqOD9Y7lfv7+idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB2788.namprd15.prod.outlook.com (2603:10b6:408:c2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Fri, 26 Aug
 2022 05:16:34 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 05:16:33 +0000
Date:   Thu, 25 Aug 2022 22:16:30 -0700
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
Message-ID: <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825221751.258958-1-james.hilliard1@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d9a3fcf-0485-427f-5548-08da87222470
X-MS-TrafficTypeDiagnostic: BN8PR15MB2788:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WIIayM4Z6M+cuN8MoI4VldaeT7qaXclYvnO4ufgPwSdWCmJV49RylCgTJFJlghk0YbPtT1aDy0LDoDgGNeR3vFKKMhENxyx7QoE+ZupXQUvhm+2+xU5ErhiE8K2JNl2wQFUcbtYpbDUqmMa79c00JKg7SzS8bbdf0Gsb+D9t3h3nIrm/1kWNg1aGzZmM89cHfGvNO0pIR31808L9l7X2qpmDkNg+MNUTkIh4XPBOxtx3Xba/K120T6BI7mg4nLmc5o3d0eM74ZA1tVO+rNe3aovOpjJt8vsGOCW7wyoOT+CsdpGmSk+r/G/8Pt8qJqmEWSkP7bqFONVmsU4sX01SGF6nuTEuViyfM/ujl3/o7Csi0S3JQHBWPgVTgVQfWH1qM04RXql2qiEbvpmQBKrL6OT8vGwR5BlgHRWnPosgBLBmDVM1r7Xr31DTjk+aAezV0qIdWNyEpsO7YaYiqrKEguFC1DxHe3OtzSJAFTgrKei3/ZXYmWgz5xUiSYSckiHdCKomDdxf0GxahC0JJD3qSO/Rfc9tjpPyaZQARk6m34bbchUEH/psU2L9sdlx5sbE3LdYKYvLNljb6WFnRfypfgSq33UHXwsyJzGJdLOYGSYUKxcA04vYG+XxATICdyMxBfsnuIZwja5UoD7LyDoBm7yNboe8GQ4E1zLatJjrLWoisT1+RvcUFQBJFcrrJLH6z/d4CopLc+NDf9chjofeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(6486002)(5660300002)(7416002)(1076003)(66556008)(66946007)(66476007)(8936002)(6506007)(9686003)(478600001)(83380400001)(186003)(6512007)(4326008)(52116002)(8676002)(41300700001)(86362001)(316002)(2906002)(54906003)(38100700002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yt07xvdwtCQVqL49tpSx5vWm/rJOl2KVwPRArsaK1zLahTE7AOcA7Bk9kGZW?=
 =?us-ascii?Q?37rVDZ7U2BNEafdIl5PC8/wkBU+aCZFJfNtfdrZAQk55adePIamEDIvxKXi0?=
 =?us-ascii?Q?HNBYckwcO9b18Ba7G2t16qZeoz4RtfWCf4DUeCSWXlSqaXQSUQLnSUl7HMaF?=
 =?us-ascii?Q?IGONS1+sKZ+P2CTqn0J2Zq06go/g1z5kdcQw+cyYrpkkJYlSgYYxsUtBwhJA?=
 =?us-ascii?Q?gG2RBRSNaTv4V9fWDzV8AJuqXawTtluA3TLAji6NVYNEpr1MrcVivEwKsnFH?=
 =?us-ascii?Q?vqDgAZgeMLVWW6p6pO1o7mFO/zRT+7bOn22ueXHQc6YvMWnHL4B3XJ+8sfsa?=
 =?us-ascii?Q?Lnon7CYOykPkyQDkFlYWFAPbFsbDGTgOAxwUTnnFsmpsVpjH6N3aRWuchmqQ?=
 =?us-ascii?Q?bxZrcuobK5zznzuTPl0BmJE7391bL8zIBURDgQVVAnb0IbW7T9Tfv6E30enC?=
 =?us-ascii?Q?BX4Z14bQIaKPrhxox64y2HhEP24CokyYMKC21UB9jtfAhGD7Iqj5IiBKptfQ?=
 =?us-ascii?Q?uHynwYZyiWiWI9Sf675VW1EzGT01W7PSkuhGoOS8GR9d9IWTvXlCYVJO1jBD?=
 =?us-ascii?Q?iY4C+vrCJOOAvZnAnd/lIopFtggi3Rig4iVAj6+8P49m9Shvcejjh5TLNjiF?=
 =?us-ascii?Q?V9NyngZunEYDSEUJGHyrz2kmq7QvFSqwzqnfhXHb5aQDHtPM/ULBgotc1aVk?=
 =?us-ascii?Q?+EnaHJvhij2FnDzzvVb+LDtPHc5vRtPlcOLSOlC9LG+LcpACMvNNx0fVlXVT?=
 =?us-ascii?Q?gjRXv5vq8AKMfepypWCAxVtQIJoQaGUYt3Zp/00NPTHUFk9e7Nw4276vY/HQ?=
 =?us-ascii?Q?aXslks4+4aaSJYVskFBGYr8jH1HnrklOC8fCTx1FmccMWNgsFNMG6QmgGwJF?=
 =?us-ascii?Q?SheId8XHM6iSMJwA4B42KzUD1vhkZ0lQ6Ad+6rxD6vVTCB+ZChLXhcYVT7qM?=
 =?us-ascii?Q?Sf2jdDRw7qqJO25B2Y3o358IyOOaXZsVvCtqw1tagImAAOBwTXGqeHy4osEU?=
 =?us-ascii?Q?wGs5b+GblpcGSRH0955Q+fX4TL9L432Nhn5ZnlT3OnUkp0DW+9/9KLhMPon0?=
 =?us-ascii?Q?R24sFhEZMbDAWgzcAWIotInTmgWd7HBkv3+QLEc3OWmFVoeHMlwrrsEGrOuw?=
 =?us-ascii?Q?pasTy+exgFKhlvC3X+ylrNPXJcaFb5IqL63bb/m7DYEsCPAgiExxZpkDz7jg?=
 =?us-ascii?Q?KDeGz21dXc++LtXeaR+K7TJLubIg71Qyu4honmNt//PHlhofL0O0lGdCU45b?=
 =?us-ascii?Q?+iqf03/TFdMeIPh3m4BaUPvztgEBbmRF2dUfa9VD0uwd3rJUj4Vl+WXygB4k?=
 =?us-ascii?Q?jyGmZbkOPQA564JSyQ52z/SSnQtUfySB8WcE/xlBNTJLi462HFNBX0fUS0hH?=
 =?us-ascii?Q?Ey0ttSZFTfdIXNidwvTKIayEY/xJ39a1T6FElA/fI2Ej6t1kFz5LEQMjBE2J?=
 =?us-ascii?Q?q4S/yK2yejLutqdX1JWXFLkcefsxU4cdZtQiabZO+fgoXNnfzDEoomqdH/63?=
 =?us-ascii?Q?AfJO3VGN0OSkOgronlq/oMxYMpZ6yx2pG2xNEAQHwqHtvhsmf6j1gDbOgV6W?=
 =?us-ascii?Q?LWFWxLu0a9b8OuyD5y5zhAE/jHY1Gsl164whIc+N/koSn+r/UIUErRzaO6am?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a3fcf-0485-427f-5548-08da87222470
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 05:16:33.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CL2sFWVeN5PcXpMZyOPCPdx+MVWPKnBQNOKIUUVehlhM7yXs/ICu3/VGnZ1ljG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2788
X-Proofpoint-GUID: 8IhFBEGOK-N2XVQpIpeON1xIIiP9EuOo
X-Proofpoint-ORIG-GUID: 8IhFBEGOK-N2XVQpIpeON1xIIiP9EuOo
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

On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
> There is a potential for us to hit a type conflict when including
> netinet/tcp.h with sys/socket.h, we can replace both of these includes
> with linux/tcp.h to avoid this conflict.
> 
> Fixes errors like:
> In file included from /usr/include/netinet/tcp.h:91,
>                  from progs/bind4_prog.c:10:
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>    34 | typedef __INT8_TYPE__ int8_t;
>       |                       ^~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from progs/bind4_prog.c:9:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>    24 | typedef __int8_t int8_t;
>       |                  ^~~~~~
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
>    43 | typedef __INT64_TYPE__ int64_t;
>       |                        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
>    27 | typedef __int64_t int64_t;
>       |                   ^~~~~~~
> make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
>  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index 474c6a62078a..6bd20042fd53 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -6,8 +6,7 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
These includes look normal to me.  What environment is hitting this.
I don't prefer the selftest writers need to remember this rule.

Beside, afaict, tcp.h should be removed because
I don't see this test needs it.  I tried removing it
and it works fine.  It should be removed instead of replacing it
with another unnecessary tcp.h.

> +#include <linux/tcp.h>
>  #include <linux/if.h>
>  #include <errno.h>
>  
> diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> index c19cfa869f30..f37617b35a55 100644
> --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> @@ -6,8 +6,7 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include <linux/tcp.h>
>  #include <linux/if.h>
>  #include <errno.h>
>  
> -- 
> 2.34.1
> 
