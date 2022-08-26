Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE265A3254
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 01:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbiHZXFb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 19:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbiHZXFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 19:05:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA2579682;
        Fri, 26 Aug 2022 16:05:23 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QKYmti029675;
        Fri, 26 Aug 2022 16:05:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PS1DW8Nes+pWBWXldDeZT0J4eMCUcEzKoh7/9efQTe0=;
 b=RGe5f38mNib+/ctWDXzSCnh0do4phhs8RtKTwrV02c012uIVKOcKnJJzlG+WZqeOVgIk
 bbMm+MhXB2toZPbZTtV9WSNXFrj2ibYmMI9uJhZN584fYmbh2pqWO1rX1vTNuJUMsx04
 ypwJAhuQdjKPQgnapmedCN+8hip2dqDSPT8= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j75b5rrqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 16:05:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCx+LavF23YCpqWjwBKYLS36WB/xbJtpJwTHd55wXzZz1jvJvgfKXm5Paj4kH2Xm65wc6FbCA1LZNYTDF1wjEAtn56YWDhIYZCVKUx8I/VJC1gxYaaTuoxOP0kt1UZYA9WLL8/xIB1ryaICwqagGFTXA+RS477Hqovjcneqez0N6wsU/qtNTyxKcL6DjLGgHmP7irC5LR0mGBwphd32l2bklCmzSEHqotxQFjrMTEqHBYKiD/OGIN/RdmEAZAraG0UxT+i1RbIPKkzRxBW1h8U5SSOB8fyZSgvs9d3KCGKvzO3yEnPL1YGSgHpOdEBPy1wCtQfHC+OYpWLQQHXIU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS1DW8Nes+pWBWXldDeZT0J4eMCUcEzKoh7/9efQTe0=;
 b=JaCPNqxjJxaDN5z6cySg77hhupuICbGw4xxem7c+RCfiBkyXofPNq5fNBlkH2kBStUAa/ZmjN7oTRHagad6cT7dsNRLZ31218fDGTSg7MAEbMX0uFUe5MMxuN+pm4nvoMiDh72lyD+feJedufTgeMSp9USIZAVxhQGj9PpvztUWZvdr+Pt5FlZicFkHV5zlOr2Af6S/9nFr3PGCQbWHpo8AByn4gLRi7cMaYNP1z/SvwxDLkHSFgkZ4m4B4fSx9ILJOFNAbFtMbgRjSxV0umOiOsmFXtuJsJ8whs+gHyAvTSem5peXst6PeKxugOt2WqAOi5ViWZH9VICHdQ/VUXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB3062.namprd15.prod.outlook.com (2603:10b6:a03:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 23:04:58 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 23:04:58 +0000
Date:   Fri, 26 Aug 2022 16:04:55 -0700
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
Message-ID: <20220826230455.b5dcrvlmollglhx3@kafai-mbp.dhcp.thefacebook.com>
References: <20220826052925.980431-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826052925.980431-1-james.hilliard1@gmail.com>
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 966005c1-293a-4ecd-e403-08da87b76592
X-MS-TrafficTypeDiagnostic: BYAPR15MB3062:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy3qTkQVG2+4gd39m76rRQJ5q4nMftVEKpdUJoYNEgxoX8eAI7VMiSO4ZLH1YbU1OVIqiP0d7hM7GBbCk8Co5/1gMjbdPnNe+LDMlUcW17NqOayaZamFLyr+SFpdlXPsIGe0OfkMpdDJyzjiftNRogcUlx3G+wj3XxFhnQQIgzeWzkGq8J8fA0bMEER2W3fzKvlzHEpM/kweilpvT+vkcv4GHKhaUbCx1ovBIXwDlJe1190OrVqj5DmQivO/EY6Cofampk3jGt9qwk4OFtuM7blUdIR4WDj0Jdym7EyR654jDbuQ7F9OvFkizhDKqLMm+ZoGX9t2zjDSn9PDOoKeQjLnn+6arGt9oT1IRw5v4dM2xbTvJSa9P6NvzG6ZL5nBRN1XDwyCsyheEfGDWAfxpO2C1d/nNTeRp1UYsm5F2WqPpo1l446wzwP8R1Hq4VJvcYRT85KeqKW11oBNqxzxfmt5AWmZY4/BW4bKfhCg89Hl4+IGfyQLzbj2/LaxjWpU8rwcD39/OA9a2l+M4brSJa+FxDzpdAVMUUxZ/V6cYvlZfJ6hMg0wS918ES6abwk0ewl0RyTnkdqNNSzRmCV5t/SLueNlSYB1FlOoAvz66SINFATYR6AxvciUzhiLclWg5USMedaYYVMHTxEqDr2MeWuu9YPY4FYENvh1qtmMDImWjuiRKPFCzVUA4QQ/U8w5t0g3Xt6MA/I1Nb7zR91GvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(83380400001)(86362001)(38100700002)(66476007)(8936002)(478600001)(66946007)(66556008)(4326008)(6486002)(8676002)(6666004)(5660300002)(7416002)(6916009)(316002)(54906003)(41300700001)(6506007)(2906002)(186003)(9686003)(1076003)(52116002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUE4m4xixifWILuEHkIcptD/RenLUHmeWWAwnpqf+9jGLB7lsdpvmWG85wSF?=
 =?us-ascii?Q?BejO/u4cQm0sg7j8Vu4YtJSGwh8qcbsmv1z94R1X0aM8DjU/yil98EvcyMwF?=
 =?us-ascii?Q?FsQBDpMFaVhK1/MpO+Chr9//2kBUeNK4h2gudcZSNQcWm0qkYHDVwWFzbpOL?=
 =?us-ascii?Q?Vjos8w32zo5UuDd4s6yXMwNctDEsLh2nyjMIa84HX2GKKd6AFFenQbbKS8g5?=
 =?us-ascii?Q?xujv/+58lu1B+asqEtBvZCSO6vEO9C68BKes160VyMCJ37VWLtHkj58amOLm?=
 =?us-ascii?Q?ZikoLGpwC2cXz9UWijXKWtxvw4zEsdT/yYynzJ38IIMu+pR+fWM+xIWEyLQi?=
 =?us-ascii?Q?B1gfFwvpi8+eoy/DAYrMUaL6ZOEg3Zwvq+Jkwrwl13aIkCVAZu5c8nAUprNu?=
 =?us-ascii?Q?uideIchM2tkNuKhkA3+wiFS+rrWwGN7fUvJo61r0VDVJIzns1KE9GQNTjXhX?=
 =?us-ascii?Q?RAnb88jWrdcCfWOnb/fNTgeXOhEmnHDaG1NUkJYKyLJrQfwFEJpTMfqJ4HMy?=
 =?us-ascii?Q?43R+CJ1ZM/X0g+Aog+hmI1yoUWO8WeviCU2TapmspqmBXVMeDA5gGc1J5YPY?=
 =?us-ascii?Q?dyKOeo/y9nj8JnE02nPlDf9PdGrI17deFxxaJHCBIX6H/73VEYYnSgkev7pD?=
 =?us-ascii?Q?oMYAVd88LspVQMzWETk16qG21yNvT41fhzCpOiOsJBZ1Jno8xsxsubUgruQy?=
 =?us-ascii?Q?DM+U0daCR1rH2Pru4CK1oYigM3av9vx0RlyXoQJB9PFY8NtGJXJ1fWm31bZc?=
 =?us-ascii?Q?CmFcGBpir1v09LsHGhfqlxzYxkSWIEOwjNpXONZ4A2OvXWS+/2SXxq81GtRc?=
 =?us-ascii?Q?AHKsCGM1ab1M4FaJih+17LWZqCBdB/db7B0WDreSOfrcCr46EhoAR/s9S08j?=
 =?us-ascii?Q?U9g1icBLzMIlNOx1oPLeSkP6k0C7dBp2jeagJDYYaOygVgVozUoohyPq7PGS?=
 =?us-ascii?Q?Lf9RL+hDQdpHcKTEvdTjhXMv5pk+g12xLY0LPX5HUITpari0c647jEFsQkiy?=
 =?us-ascii?Q?k7wi+6z9oN3AWNtuwQXFKvAFK4kWmm5SbRft7+o5tGph5837NKXshT3NwyXl?=
 =?us-ascii?Q?Iz4C1btjPj7DJ1j+xLhIne4diZ3LnPC0kwqPjcef3kP9neL1BIuxfxXmX78O?=
 =?us-ascii?Q?BN+vUaaWlEOwhkdKh8kYx4Aql+l3lGiZYjbKfvdEeohVBaedUcvfpHp71Fw4?=
 =?us-ascii?Q?+eVTvvyxjrGsBSTVVhteXSKdaEV+dDEUA6da3crFcnk6g87yPM9n1zYGyWZn?=
 =?us-ascii?Q?+nVIatC6VeFYs8LAmfJdmFf9OeX71wQ6SbQOkzQMUCq4FHdt+9hTYkjFwmvG?=
 =?us-ascii?Q?9Tx3VKz7GJ9bCIPpYUVDQ3wMsDmZbMgdtpPr7thXRh6JJLZwsv39vx+1eNxZ?=
 =?us-ascii?Q?iY24zNtaTWUo3FsilW1LygVlWNhLgWnFkGiLcRfroDfUQRdnlzMWx3FOvzm9?=
 =?us-ascii?Q?LkpB5dSj73vYQe9jrBZgWdGy5sZLub5AYxDGNpMupC883i0mVziGufB/IOQu?=
 =?us-ascii?Q?N8gfv1M/FoDCBL+iAV8m7N8JBUkqkY98oPznkZj7jPpj9qyMFxoMlHCIao9H?=
 =?us-ascii?Q?/uSHwwlolztBNub/pP0Su/LswvOpoyjNKCJ4PMPnRVgWMu4Kcd+7pyxMkYce?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966005c1-293a-4ecd-e403-08da87b76592
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 23:04:58.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZpbZlZsiGB06+c5y/ex3jQ/QFbUJvjOdD6ydkw4Y0NuikUhfwtnNX/lFaJ+SJzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3062
X-Proofpoint-GUID: KiWwsDDqgtsnD_p_XTXqJGrSXCon-6BO
X-Proofpoint-ORIG-GUID: KiWwsDDqgtsnD_p_XTXqJGrSXCon-6BO
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

On Thu, Aug 25, 2022 at 11:29:22PM -0600, James Hilliard wrote:
> There is a potential for us to hit a type conflict when including
> netinet/tcp.h with sys/socket.h, we can remove these as they are not
> actually needed.
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
> Changes v1 -> v2:
>   - just remove netinet/tcp.h and sys/socket.h
> ---
>  tools/testing/selftests/bpf/progs/bind4_prog.c | 2 --
>  tools/testing/selftests/bpf/progs/bind6_prog.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index 474c6a62078a..a487f60b73ac 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -6,8 +6,6 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
>  #include <linux/if.h>
Are the AF_INET and SOCK_STREAM coming from linux/if.h somehow
and they are not from indirectly including sys/socket.h ?

If the program does not need if.h, what should it use ?
There are other progs in selftest/bpf that include sys/socket.h
and they have no issue ?
