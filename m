Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8727402B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjF0R4p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjF0R4n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 13:56:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2D8272D;
        Tue, 27 Jun 2023 10:56:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35REQjHv017158;
        Tue, 27 Jun 2023 17:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2ZbDUqc4Ip+FJIgxq6nxq1XWnL88tnWaBXxaquQst1o=;
 b=igFw1439sRetyKKVaKLAA9IbaOQhcNXdw7qeRNpT5TJx0vgFNGDJfPoBnMDMeP+TPAdA
 xEeFjhiz0hJIkmnULd1bmvr34gm8BNPbKf29inaWAxpRdO7HLixOykoaNkf6tcvQFhcs
 Oq/6Hwr9LPJqqawJaPD1M8J13SFZPc3QjtvU0HZhm0082fMhDKKob0Q0G5VcKq68kt0i
 lpwSN9c1M+C2hrOEZ4+2FY4Qe2f/3mM+EsygmQDbnZCnuPafJGFs7UQFACPMI9R7sz2G
 yIQQkCCMKI5amYbW/FKSU2A/NcVtXTsdvB6l3ZIXJkuCXuQS/kHHRPWf5ojnZkcdDBBj Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u5hbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 17:56:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RGPGrL013186;
        Tue, 27 Jun 2023 17:56:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx53jvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 17:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWyM+9eAnEVxYpJUHrqIpiJtPelSd9e6fd/4N0d3bW4qtxSMzdq8pTduDoCFLUeyd2C3vKOH9iNVXhcHrfaMwluEXrp6f50HnVr+ec2RLSRG1H204Ba92ydX4NckQZYxcm46F+RioP7kzas2d/avBnrxjRBWSRSMNEYJM7nnEXSp0xJv0c4hh+PGyBG9Y/4IdDyUjGWKWgFCx/5hz1NOko3tPtN9vQyUJfXlZ27jeKF8DP8DUapmKkMZyG7azNf89CVieKvLsgOXWRSqJeX8c+2nrT13wXryChzYZW77x0w4v5eY4DYhnEeP0tkedKDOtvPURZiG+wv4mClUj0uAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZbDUqc4Ip+FJIgxq6nxq1XWnL88tnWaBXxaquQst1o=;
 b=XEyNbFjL1woDhaT002pQxp5woVuhlZqGpwHAsl9EY8eXFfmkE3c66cTmstT7ZyY3u/rgwBP87P1hzZYm7vlKKuvUS76gfXJOZYtyPsPx8IAJ0qh+ilxT+iaUL/FEur/+cBDc/4baoRb6y7oKpKvUQyDVWOP5s+fMcJZ5OFXPXI1gJTFHr8Em5s8xhCEaKGjePv7KpN533j5Px+peLb11l9aT/l85qNfjVH+ArqObxZhNEnVcL+iWaHQNWIwk3b0xlTKcyn7dyKALo2kaUSWVCvxLzfP8EpOBGllQ9XF6k48PfASR6DBJiThbXCGoPYWfR+FZdGcwluUTRA+gK4vV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZbDUqc4Ip+FJIgxq6nxq1XWnL88tnWaBXxaquQst1o=;
 b=jBDhbp00y5oyNAXKtIOFm5amBys/YWJzbnm+oBziVkPvq1HHGrYrBYkDA6lw4IsSnvnLlelfV0IjRFXiUWE19J0YCl0Oi54pwwg9SWwrlin0ah2uEQFP6pH+oT/IT7M6cmMy2mxlfYzmGan4SkZUk0gfIXfQRZLd1zb/gSlbCmk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 17:56:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 17:56:13 +0000
Date:   Tue, 27 Jun 2023 13:56:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 1/7] mm/mremap: Optimize the start addresses in
 move_page_tables()
Message-ID: <20230627175609.xrn4mle6hpi6exh7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
 <20230531220807.2048037-2-joel@joelfernandes.org>
 <f2f751ca-217e-4177-bb7f-1c9cd71e103e@lucifer.local>
 <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87df265-7e58-5907-e215-953630a87155@joelfernandes.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1f996f-f8af-4215-16b9-08db7737cc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8xER6GdOLlQlDppuyS3hXcfEUv6TVaSOlA/X8V3o7mfp1NIQe92wdZJY/hy3ezWW7DuRirwJyirRKnnl9fm2bPzlTxQdqs+GoGFY0xeW0bY5GBokVaFRDD1eyBsVpWkR50hs/Ot9LQbWvG0Zhkg2/8l1LtnUHOTOmpAAPeJHH6vvgU7nTFe7WyDaN20Rdl/kXlGuJ7tq4BWxQ+r/3fwiKox23A1L0MZs1WTExWo07Xeu2nMFN0sjU8Fn1QqGbnuVze8nz9ruazIvphSBX4sXsrOJoTNL/RIKSNpb10+aU8GEx2KyR7qZSH79t9sjP/DDibOo7eZx+swoK0wdjIyF4db+eixoqJbRWYraRgvP30JlQS/5CRex6lJILkowcaAHn7wi2lgEj00Q2fHjWK4lt8995NvWmvYatMjv4f6JryGzfEPzjlUworHBhcXru+yEX4yDPZSnMDio3HKH3SEFxOgVyctThxPwgfvjqViU+28jcbaJVzfSYx9sU38TCDsDHcUn8/MFcCSpoBC8g05fvjso/YtcWxyMy0X8JXEcKJfPhoRD+YbVMKxgUQaewft
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(6512007)(9686003)(4326008)(6506007)(186003)(6916009)(53546011)(1076003)(26005)(6486002)(54906003)(6666004)(41300700001)(33716001)(2906002)(5660300002)(7416002)(30864003)(478600001)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcjT2/Pq7DzNI/V6aB36iVB+EbWkOPGuUOxhKvHmPSa49xdUkTS9rheL2JeD?=
 =?us-ascii?Q?3GJfPjekaKFeQ+g1Spl5zVvbHMsjsadLoeomNRNHkSFTKtZMPxEfFM+ORkza?=
 =?us-ascii?Q?995FlZW0srMr6kfvcmPFAU+SJeGX2iUuI6ng2JZ8powMm2IWp+vQfchJ0QOS?=
 =?us-ascii?Q?Zbxuv9Lpg9RpC4UBckUCHeLh2IRPQKl1zrISNnnAxRlxkzltObi17lsqH5kK?=
 =?us-ascii?Q?hjO+V+ArG3c7GskT543/vxk/cnlxTbXXVmzsZ1t+Yp/05ybTm9VKeKZJSOXJ?=
 =?us-ascii?Q?OSxjaX+4n0YfI727kF1HpDsQxF3DJPy2Mlv/gLnWoB+gbK0/uYhIA6qwAgny?=
 =?us-ascii?Q?2h1yxd6fi4H4mrEzkvFHAaXWa+tb4o8Cy3oxKhrt6DRVMrlvlIMXpaiaf0fg?=
 =?us-ascii?Q?L12fspQuErmCz4kmGolsYC/98rYQmnYF6wAjsL8uVHv1Cvyd0pQfjE49iZ2U?=
 =?us-ascii?Q?Dv6VDxvOzdnKfDgD0JFeZZKePj3m0+ic4V4d3bT/204Xk+aUU+FWz06y894r?=
 =?us-ascii?Q?waz7yzyzElTC4etyEU0tZYtTKdjpdA/v5NJi9SCKtDp8PYZNxEQ7heTfQD9Q?=
 =?us-ascii?Q?aurDCaJaUteAAm8TmEKC+ouZgxDSpWaj2HNzXdo4Q+rVU7Yj2M9QBP/HzbUF?=
 =?us-ascii?Q?LZv4meyuSY3zxBAZGNrmO7jAUklcpMOaikRRO9eMVedodUxSl2G2ZU6fFDGH?=
 =?us-ascii?Q?JiRp+dzUYaQP7MqTG0UYHIt4n5i/XckU9VKY/WXly2QnYnZyi9A6JT6t80+6?=
 =?us-ascii?Q?NLcHbTOBhIFEI+cbxY06xT+QKqM2/GAE1P2w0W8ttzQAfEtbT0pH6PI/Sjhb?=
 =?us-ascii?Q?ynAkChdtsR/flkZEG8+K/TTxSjxiqmffTjezpmSQTJnxoTcokpbw0nhuPJym?=
 =?us-ascii?Q?6MAe4J9jPdzlsa/e/lEd32cbvaGo87nSehDWYvz1V2E9gexdxwaUNraJI/7q?=
 =?us-ascii?Q?V2+ikaVd5nzq8LDZGefnHa+gFv5pHEKCaFiy0XoEDGY1iMO30KNTRg969FsO?=
 =?us-ascii?Q?Xc0p5sdZp+LSuqB9ij8W9M1ja6cvqaCU1gQ4MBpw2kY6bfp245NbwCcraBUK?=
 =?us-ascii?Q?mZvF+g8NzzhJG0TRw7O2S5+5E1fRHERgAMMpPvmtSplv48Jvdr9gKXXQIFtB?=
 =?us-ascii?Q?xlIvSMFMSVOi0hOzCw5KDoCxZT7aDHVX3WFJPhTrikml1aPSLnvnEetsESBB?=
 =?us-ascii?Q?2P0vo8mfPOWyU5IvL3fod7PiqGXzYGcWjaR3wVKpWzdAejlXKISN6RkJgFGn?=
 =?us-ascii?Q?qgHh2jOnyPf41ASDr5iThn1fNtW4gAC2e3K/ILrJJW6lYUobrbsf0If12gJu?=
 =?us-ascii?Q?TaeATk7nFWcmdZL6hlqrfGQ5iWFZzyAteSn/BXGw+eH9ojA92u8GrcPe4PvW?=
 =?us-ascii?Q?O0S2tcfhJDLJInXPlRwcUj0hrzpFHwN++KAQ9lttw137hn+Bolk4H32rD42g?=
 =?us-ascii?Q?1Rr8drq3C3VhyyJ4s89af2vY1rqLn1pzdSYHXoTVmcg1gsmXEDuXyRA9cxIL?=
 =?us-ascii?Q?7eGXY/Vj5DxLB2IQ9T0ZvJoAyAzYHiDAqNDZx0qle40NM4AvUHzSKXT5MCXt?=
 =?us-ascii?Q?aBmIYiLycbqo+QM+I3mkE6BaFrEsVSPN5a+VZaiTHwlBirKIUiOdRaDGKt9f?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SAg02+CC380s0OVSPD7qtvpxYppLX4ofoRYJoKigfBHK3gzfjgkoXoBqwVNm?=
 =?us-ascii?Q?+pdp1xiJITyKzyabbEZO5J60e6AiqvufQpmP+xCRRI5RXHULRuSopROwLcq0?=
 =?us-ascii?Q?n3i7E7IAgeDrLRVfSa4d9Z/qDfjJNtbH1uLyVpA8QkWZtXReZjj7Gq/VZf5R?=
 =?us-ascii?Q?KmMg6k2m7OtNckEbU+BjFi8QqkLclXC12BRQbyOJBEM2fHqHbVfUyuMWt+Op?=
 =?us-ascii?Q?ibJ2Kn0F3gUk3MVSYo6rGOuXhsy0z6BC+hNFJqqA/yb8wihZRD2MtB5hSdH/?=
 =?us-ascii?Q?WJZOtEkTF2siDGBsA4sfF6JqoLqsY1JK3Y5RsLQdxGeQ11lnUA5WRWqvsA4D?=
 =?us-ascii?Q?XlDmIEO0AneSWk8z4mGPSRVLwT32UfFE9n0D2NSicD081oszH9jyU408fZEg?=
 =?us-ascii?Q?jDY95Dh1hi/5qVZ22FBBZx63/FaqYwOHC6WvMIRizXZUogMLkLlNC17zmjgz?=
 =?us-ascii?Q?3De8WU9q+f0pYQAITQyq7wnOopxsJYb8lZCInwWLu2jdQeeQKIBGhCAsyOpZ?=
 =?us-ascii?Q?sLEDfoLi4WBgdUHwk+6YY6ZO+8cet4vTIaBra8i2OVc7m6znRme0mL+vAfIk?=
 =?us-ascii?Q?np/xRrvF2iTYGeuDpyks0p1N47nPnwjrK4MIPC37HoJckkl0kGJHgAnnymOL?=
 =?us-ascii?Q?oPAlxkil7jcp2Md8odUgn2DIqsLboxx2tDXWaeLq4AjO2Q/6kPUO9k9MRlAN?=
 =?us-ascii?Q?RCtN6mJlEIYOnE0ervI+WRSAGDoer0D33qZInz3Fb6eAAC5jFaS04J5cw8D9?=
 =?us-ascii?Q?nVzyhSNil6kLtVdqIx2cp/9AGnbEfv25fVdSB9cs21isK4U1qzsuUNDkRSnL?=
 =?us-ascii?Q?6C2i7iqjWwyBJ+Hiel9XpcrCavU6q8IR7aZggk3Blv4abCeligF+FwGru/xs?=
 =?us-ascii?Q?aodCx0i+RWP+Km2vIOKmOAqyj8C3rLY89nOQA2aLAeGvi/ZWVEDEBbcGpCab?=
 =?us-ascii?Q?Bqbeh7a5XckCFjIozvjMWt1BuExQryofs+rMO4nR0zjGrB15F0jwhL54JspG?=
 =?us-ascii?Q?p1YZdQivW1+msf7mnDxME0ycEQZGuMy2TaRJsa54Tf36GQKlT5UlgZS3dQ9k?=
 =?us-ascii?Q?t2DKTJiDXj7ORk8/msthpdS546tB4qFZ88Md5E5YUaSpJg6L0wM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f996f-f8af-4215-16b9-08db7737cc03
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:56:13.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01h2OVpebe2FI9VDrzNngcS1N/wW/JGiuM3toPpIn/lYnoH7xoYAsFSgR626ItXMJKicFUANBHkaK8kSMBDdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_12,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270162
X-Proofpoint-GUID: kj_fUOZ-C07ehyoOYegDyfUY5-QAkwLt
X-Proofpoint-ORIG-GUID: kj_fUOZ-C07ehyoOYegDyfUY5-QAkwLt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Joel Fernandes <joel@joelfernandes.org> [230619 11:55]:
> Hi Lorenzo,
> Thanks for the review! I replied below:
> 
> On 6/17/23 18:49, Lorenzo Stoakes wrote:
> > On Wed, May 31, 2023 at 10:08:01PM +0000, Joel Fernandes (Google) wrote:
> >> Recently, we see reports [1] of a warning that triggers due to
> >> move_page_tables() doing a downward and overlapping move on a
> >> mutually-aligned offset within a PMD. By mutual alignment, I
> >> mean the source and destination addresses of the mremap are at
> >> the same offset within a PMD.
> >>
> >> This mutual alignment along with the fact that the move is downward is
> >> sufficient to cause a warning related to having an allocated PMD that
> >> does not have PTEs in it.
> >>
> >> This warning will only trigger when there is mutual alignment in the
> >> move operation. A solution, as suggested by Linus Torvalds [2], is to
> >> initiate the copy process at the PMD level whenever such alignment is
> >> present. Implementing this approach will not only prevent the warning
> >> from being triggered, but it will also optimize the operation as this
> >> method should enhance the speed of the copy process whenever there's a
> 
> [...]
> 
> >> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >>   mm/mremap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 61 insertions(+)
> >>
> >> diff --git a/mm/mremap.c b/mm/mremap.c
> >> index 411a85682b58..bf355e4d6bd4 100644
> >> --- a/mm/mremap.c
> >> +++ b/mm/mremap.c
> >> @@ -478,6 +478,51 @@ static bool move_pgt_entry(enum pgt_entry entry, struct
> >>   	return moved;
> >>   }
> >>
> >> +/*
> >> + * A helper to check if a previous mapping exists. Required for
> >> + * move_page_tables() and realign_addr() to determine if a previous mapping
> >> + * exists before we can do realignment optimizations.
> >> + */
> >> +static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> >> +			       unsigned long mask)
> >> +{
> >> +	unsigned long addr_masked = addr_to_align & mask;
> >> +	struct vm_area_struct *prev = NULL, *cur = NULL;
> >> +
> >> +	/*
> >> +	 * If @addr_to_align of either source or destination is not the beginning
> >> +	 * of the corresponding VMA, we can't align down or we will destroy part
> >> +	 * of the current mapping.
> >> +	 */
> >> +	if (vma->vm_start != addr_to_align)
> >> +		return false;
> >
> > See below, I think we can eliminate this check.
> >
> >> +
> >> +	/*
> >> +	 * Find the VMA before @vma to see if it subsumes the masked address.
> >> +	 * The mmap write lock is held here so the lookup is safe.
> >> +	 */
> >> +	cur = find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> >> +	if (WARN_ON_ONCE(cur != vma))
> >> +		return false;
> >> +
> >> +	return !prev || prev->vm_end <= addr_masked;
> >
> > This is a bit clunky, and I don't think we need the WARN_ON_ONCE() check if
> > we're under the mmap_lock.
> >
> > How about something like:-
> >
> > return find_vma_intersection(vma->mm, addr_masked, vma->vm_start) == NULL;
> >
> > Which explicitly asserts that the range in [addr_masked, vma->vm_start) is
> > empty.
> >
> > But actually, we should be able to go further and replace the previous
> > check with:-
> >
> > return find_vma_intersection(vma->mm, addr_masked, addr_to_align) == NULL;
> >
> > Which will fail if addr_to_align is offset within the VMA.
> 
> Your suggestion would mean that we do a full VMA search starting from the
> root. That would not be a nice thing if say we've 1000s of VMAs?
> 
> Actually Liam told me to use find_vma_prev() because given a VMA, the maple
> tree would not have to work that hard for the common case to find the
> previous VMA. Per conversing with him, there is a chance we may have to go
> one step above in the tree if we hit the edge of a node, but that's not
> supposed to be the common case. In previous code, the previous VMA could
> just be obtained using the "previous VMA" pointer, however that pointer has
> been remove since the maple tree changes and given a VMA, going to the
> previous one using the maple tree is just as fast (as I'm told).

I think there's been a bit of a miscommunication on that..

If you have already found the VMA and are using the maple state, then
it's very little effort to get the next/prev.  Leaf nodes can hold 16
entries/NULL ranges, so the chances to go to the next/prev is usually in
the cpu cache already.. if you go up a level in the tree, then you will
have 10 nodes each with 16 entries each, etc, etc..  So the chances of
being on an edge node and having to walk up multiple levels to get to
the prev/next becomes rather rare.. and if you've just walked down, the
nodes on the way up will still be cached.

Here, you're not using the maple state but searching for an address
using find_vma_prev(), but internally, that function does use a maple
state to get you the previous.  So you are looking up the VMA from the
root, but the prev will very likely be in the CPU cache.

Assuming the worst case tree (each VMA has a gap next to it, not really
going to happen as they tend to be grouped together), then we are
looking at a 4 level tree to get to 8,000 VMAs.  5 levels gets you a
minimum 80,000.  I've never seen a tree of height 6 in the wild, but you
can fit 1.6M to 800K in one.

I think the code is fine, but I wanted to clarify what we discussed.

> 
> Considering this, I would keep the code as-is and perhaps you/we could
> consider the replacement with another API in a subsequent patch as it does
> the job for this patch.
> 
> >> +			 unsigned long *new_addr, struct vm_area_struct *new_vma,
> >> +			 unsigned long mask)
> >> +{
> >> +	bool mutually_aligned = (*old_addr & ~mask) == (*new_addr & ~mask);
> >> +
> >> +	if ((*old_addr & ~mask) && mutually_aligned
> >
> > I may be misunderstanding something here, but doesn't the first condition
> > here disallow for offset into PMD == 0? Why?
> 
> Because in such a situation, the alignment is already done and there's
> nothing to align. The patch wants to align down to the PMD and we would not
> want to waste CPU cycles if there's nothing to do.
> 
> >> +	    && can_align_down(old_vma, *old_addr, mask)
> >> +	    && can_align_down(new_vma, *new_addr, mask)) {
> >> +		*old_addr = *old_addr & mask;
> >> +		*new_addr = *new_addr & mask;
> >> +	}
> >> +}
> >> +
> >>   unsigned long move_page_tables(struct vm_area_struct *vma,
> >>   		unsigned long old_addr, struct vm_area_struct *new_vma,
> >>   		unsigned long new_addr, unsigned long len,
> >> @@ -493,6 +538,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >>
> >>   	old_end = old_addr + len;
> >>
> >> +	/*
> >> +	 * If possible, realign addresses to PMD boundary for faster copy.
> >> +	 * Don't align for intra-VMA moves as we may destroy existing mappings.
> >> +	 */
> >> +	if ((vma != new_vma)
> >
> > Nit but these parens aren't needed.
> 
> Sure, I can drop the parens.
> 
> > Also if we're deferring the decision as
> > to whether we realign to this function, why are we doing this check here
> > and not here?
> 
> Hmm, well the function name is realign_addr() so I kept some of the initial
> checks outside of it where we should "obviously" not realign. I could do
> what you're suggesting and change it to try_realign_addr() or something. And
> move those checks in there. That would be a bit better.
> 
> > It feels like it'd be neater to keep all the conditions (including the
> > length one) together in one place.
> >
> >
> >> +		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK))) {
> 
> Well, yeah maybe. I'll look into it, thanks.
> 
> > You don't mention this condition in the above comment (if we have this
> > altogether as part of the realign function could comment separately there)
> 
> Ok, sounds good -- I will add a comment with some of the explanation above.
> 
> > - so we only go ahead and do this optimisation if the length of the remap
> > is such that the entire of old_addr -> end of its PMD (and thus the same
> > for new_addr) is copied?
> 
> Yes, correct. And in the future that could also be optimized (if say there
> is no subsequent mapping, so we can copy the tail PMD as well, however one
> step at a time and all that.)
> 
> > I may be missing something/being naive here, but can't we just do a similar
> > check to the one done for space _below_ the VMA to see if [end, (end of
> > PMD)) is equally empty?
> 
> We can, but the warning that was triggering does not really need that to be
> silenced. I am happy to do that in a later patch if needed, or you can. ;-)
> But I'd like to keep the risk low since this was itself hard enough to get
> right.
> 
> >> +		realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
> >> +	}
> >> +
> >>   	if (is_vm_hugetlb_page(vma))
> >>   		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> >>   						new_addr, len);
> >> @@ -565,6 +619,13 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >>
> >>   	mmu_notifier_invalidate_range_end(&range);
> >>
> >> +	/*
> >> +	 * Prevent negative return values when {old,new}_addr was realigned
> >> +	 * but we broke out of the above loop for the first PMD itself.
> >> +	 */
> >> +	if (len + old_addr < old_end)
> >> +		return 0;
> >> +
> >
> > I find this a little iffy, I mean I see that if you align [old,new]_addr to
> > PMD, then from then on in you're relying on the fact that the loop is just
> > going from old_addr (now aligned) -> old_end and thus has the correct
> > length.
> >
> > Can't we just fix this issue by correcting len? If you take my review above
> > which checks len in [maybe_]realign_addr(), you could take that as a
> > pointer and equally update that.
> >
> > Then you can drop this check.
> 
> The drawback of adjusting len is it changes what move_page_tables() users
> were previously expecting.
> 
> I think we should look at the return value of move_page_tables() as well,
> not just len independently.
> 
> len is what the user requested.
> 
> "len + old_addr - old_end" is how much was actually copied and is the return value.
> 
> If everything was copied, old_addr == old_end and len is unchanged.
> 
> The users of move_page_tables(), like move_vma() should not care whether we
> copied a full PMD or not. In fact telling them anything like may cause
> problems with the interpretation of the return value I think.
> 
> They asked us to copy len, did we copy it? hell yeah.
> 
> Note that after the first loop iteration's PMD copy, old_addr is now at the
> PMD boundary and the functionality of this function is not changed with this
> patch. We end up doing a PMD-copy just like we used to without this patch.
> So this patch does not really change anything from before.
> 
> The following are the cases:
> 
> 1. If we realign and copy, yes we copied a PMD, but really it was to satisfy
> the requested length. In this situation, "len + old_addr - old_end"  is
> accurate and just like before. We copied whatever the user requested. Yes we
> copied a little more, but who cares? We copied into a mapping that does not
> exist anyway. It may be absurd for us to return a len that is greater than
> the requested len IMO.
> 
> 2. If there are no errors (example first PMD copy did not fail), "len +
> old_addr - old_end" is identical to what it was without this patch -- as it
> should be. That's true whether we realigned or not.
> 
> 3. If we realigned and the first PMD copy failed (unlikely error) -- that's
> where there's a problem. We would end up returning a negative value. That's
> what Linus found and suggested to correct. Because (old_addr - old_end) will
> be greater than len in such a situation, however unlikely.
> 
> >>   	return len + old_addr - old_end;	/* how much done */
> >>   }
> > Also I am concerned in the hugetlb case -> len is passed to
> > move_hugetlb_page_tables() which is now strictly incorrect, I wonder if
> > this could cause an issue?
> >
> > Correcting len seems the neat way of addressing this.
> 
> That's a good point. I am wondering if we can just change that from:
> 
> 	if (is_vm_hugetlb_page(vma))
> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> 				new_addr, len);
> 
> to:
> 	if (is_vm_hugetlb_page(vma))
> 		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> 				new_addr, old_addr - new_addr);
> 
> Or, another option is to turn it off for hugetlb by just moving:
> 
> 	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
> 		realign_addr(...);
> 
> to after:
> 
> 	if (is_vm_hugetlb_page(vma))
> 		return move_hugetlb_page_tables(...);
> 
> thanks,
> 
>  - Joel
> 
