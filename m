Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8A5A2C5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 18:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiHZQeB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiHZQd7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 12:33:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA6DC5E1;
        Fri, 26 Aug 2022 09:33:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGTUSr024644;
        Fri, 26 Aug 2022 16:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jNpycLwdmROB8/1wREwXx1ORmovoOtMdeltnxerdpBU=;
 b=iQFhL22ZEkvWvO4vWN761OZWNE+d5NtEnwBWCXPZBd18fBKBHBMItQi+94IAy3VQYeKc
 piwfII6mVrZkizmHCEkRD6efhGbz8mApqGps45VX7i2aZVwDm3GZfZ9SS0sg1flEMbFL
 L7Ot4BTrcHIFaMAqj2fmoejFqtF0D5DbyI3Ppu/XopH4VVjbNUOEKWdPVKFDRXmIOVCp
 4EtN+ctgOri9YtP8v91rNysYI8cQxlqx4x6qkaqXXuOcGycQyr45oUipdarFetA53eBq
 EDRQT/NzW8ScwrGZ8kJ2Pqjcncs0OCCwtY+4DTQSMFzjd6jedHTNY4GOw5p+GLpEfdpg 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p28991-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 16:33:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDqJKA004705;
        Fri, 26 Aug 2022 16:33:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7daybb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 16:33:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2xVW09lBVndBCtK0V+0r25EsjKCzHh+RJ4fBnalO4dpIewQac3pX+OHpyu1zK4feoRJHciO7do1TjuLmmLzADJ/qr3lp/eq5+ncxH444iy8Cxi2cwkYH/dwxL59GRkgdvgaKbKV/3h42znNFh+wWP0LUHJ9wrd1uM4/Z6m83H9OTAV7vRJkOR4EvWgl95X9qa3qWg7/+4UXoLrs1yfa4VP1wL3+lEIjVwkj7b0+chAWctroNjjRd/UioolX/LoR/+Q5K9bU3Mt1nvjG/yI71sXpTALNJ0d9O+OBpYt8FT61ywcHMpdDJhVMBmty+kkjOFEMnQFnDQ0FNU+GW/qX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNpycLwdmROB8/1wREwXx1ORmovoOtMdeltnxerdpBU=;
 b=PbBAj5ZBp1uJHiCLArXHx7CA65S6D9INNcUCLF8bduLVXiftJB5VB/F/bIK8n34Gbu0QmLFdL5KRitvgNTdCe4dDwUGT91Mhjlab0JW3SKgq1gw1jW7MWnFtnzH9f70P5B52oPobErhJm7jhJBrVg2Zj3nTEiB4KWJ9t6u9KAXonnG1jR1nY2ghjN4dRNES4c3BtSKoKo321nrmTj2HQW7zA5U78Z6O4Rs6LJE+4wHZooHPQoPxE2P9fuNAPQQUBW9TmTGxbUGhZCR7WNOE7796sQIlG4rFcP700eGq5SuuRMcuqi9LxBKyFhvNaZgNuh74Bzx9uiSe7qQ/CQGgVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNpycLwdmROB8/1wREwXx1ORmovoOtMdeltnxerdpBU=;
 b=qyLayYBUrrJvdSLKYP46lXvC9B3kp5Pe8Weo/C7LBicVMRzxCFQIIbRYIy8TkSS7T50bVG2LoEjn47c9zvS2WNFkuWxFY91dzcPDUgxrqdsGhVUQGY1RV9ouJcDI+EoGzl6d4Zj8Tqlr/6mA+09Y9Ahm3iECNJeH9bH4DYyKTHw=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN6PR10MB1300.namprd10.prod.outlook.com (2603:10b6:404:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 16:33:31 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::6440:83d5:754:2daf]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::6440:83d5:754:2daf%5]) with mapi id 15.20.5546.023; Fri, 26 Aug 2022
 16:33:30 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
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
        linux-kernel@vger.kernel.org, david.faust@oracle.com
Subject: Re: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type
 conflict
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
        <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
        <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
        <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
        <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
        <87k06vdtwu.fsf@oracle.com>
        <CADvTj4pjOu8zupK=-Vmr9Y4B3ojjBshUC6PN+_9AJQh_YXngww@mail.gmail.com>
Date:   Fri, 26 Aug 2022 18:33:05 +0200
In-Reply-To: <CADvTj4pjOu8zupK=-Vmr9Y4B3ojjBshUC6PN+_9AJQh_YXngww@mail.gmail.com>
        (James Hilliard's message of "Fri, 26 Aug 2022 09:25:39 -0600")
Message-ID: <87czcndkxq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e200faa-114a-4e7f-823a-08da8780b57a
X-MS-TrafficTypeDiagnostic: BN6PR10MB1300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ma5PGiZlH4K5DICpkXHwf/Lvsj8D6d97fxvaPk4ZgCPpc1QfiDejqHi+b69y3sfiQZ5oFCJvzvDW+DZzeIcICM3AITp3mcKj79I4cj6JytIsYOVwflxtnng2GQ1Xm+pswNIjBkmiyhMuxBi2FYCOoRn7bG36Vi6bCj+ZnWidPfG9FeMtw4Srv/Z/P/f923WryEekf7q5dynkOlRNMuL/TLMO0vWBu7jGltoh1OIoZpVu/G4avPICPPFtJdm09AfrlsQlpVbmIRWL5aCrd5qiwf0R3SVP9nHTxdtNOlpaD3JdyAAr0a9JIhFOVnpjZrlYlQ1VuEZYLEVB6zubNWsEs0y3XxPYPOPPd0MlK9Xm3X0KhuU7yGhjJpMlfsm9SMNLi7ezWnf5xXU16CQUFzyN+RRVVWmDjJeqd28HJjDB+SzGuqOoIbl3z8jspRU7DgoAi3Tq9aMqZSp0Q4qiMB1W2gX+BQlaal28Q0kGdGw6OevRVzDCIavZ+c2qHUTBhxUAH3DCpf1tsFfwXJ/xxDMJ9cqIrWve7AJAbNt2aZEEMkcdtVvendgojoyc+hrClY89jMJ20mOa0bwyo+i86aGggf7TMCaLaSoZ5k+cdVsZJnqQsBexH+MB1XESrcFXjoTqmZIKAbsbTtnbZxi5T92FiF2jJM88xquJsQozmjcYTJrbgr7SQHiJGiQu7/hVpCHvXiBLC5Y7fdfTsfwhSU+QaMnKnenioNR08T7rh7Pmzng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(396003)(136003)(83380400001)(7416002)(5660300002)(4326008)(2616005)(66556008)(66946007)(66476007)(8676002)(107886003)(6666004)(36756003)(6512007)(2906002)(6506007)(8936002)(186003)(6486002)(53546011)(26005)(966005)(41300700001)(478600001)(86362001)(6916009)(54906003)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVmOYZDH3bV7kmcg0V3FgfMnpsae4z5rUje68prJTjnfDZn6qbLZMJynuPx1?=
 =?us-ascii?Q?ieeCjogoMKvoxdgo14qX3o0od7JOpBZx1da2s2YH2N3Fg77b+WTvMHHHPmQb?=
 =?us-ascii?Q?5oLt+ho2Ys3hPQ5vpNS8t9OOXI4bRXFlozCJWZGBbdpbPzgM66cH7xHbSSeP?=
 =?us-ascii?Q?nVv44KT/Rs4yjsUr82pkmYqUbCqF81KqdglAuvpe88hkC+z7gaP1DfOfcg3g?=
 =?us-ascii?Q?FQcHN+fbQg/YR5YZT99HwEOb2zEqtModqey8DUv28cp/APaQTEHoLlNutGoa?=
 =?us-ascii?Q?lfpZIdfci2EHTDvBwIKTCNqq5sHMAGp00JHv+jcofc1XXz4afTnsvTKXPb6u?=
 =?us-ascii?Q?/3VOMk3u0xn08mKWoG1EIobn/Tq7AHqFbThNahoPoYYpGQtg6zqSu511hF4f?=
 =?us-ascii?Q?jODZ2Jv5MIV1sDt0TDoGppZgCAiFI4EmSzX88nr0p2YBh0gQ91yxiFbg5ajD?=
 =?us-ascii?Q?QlLA40+c13UsOZAnpIyrUFW1y9uayhJEeeokuOcizxyklQgE8yqpzikNqn9q?=
 =?us-ascii?Q?pq8GDEoRYKpVp09/msxTfvU02oT8JJk2P1cN2AMxnfCRBxDOA/TZWLntysvY?=
 =?us-ascii?Q?wOpFrP0LtSvXGTv3mcVrYhRAUkrSxvyCiWbn3UyTDjdi8Dn+lLauXpIb1t+4?=
 =?us-ascii?Q?R7o1w+yRaciimpYpToTW00aXbx4+yTDbxaXT+FbGQx7efrWbNhx74eIjNVWq?=
 =?us-ascii?Q?c3gwKcx2GQT67dRsJe/JCILgFzn3MxHvJAi8FU6fN7VND0+41X+QtOrHZ4S8?=
 =?us-ascii?Q?zaPOwIbEatsR7hdoZjhxRhjU8x+kJSDYhF5mnsuhJMMvq5YuUqQK6O3qM5A8?=
 =?us-ascii?Q?Tq2QJJiy1/hYb0R7vLf8YbwDRlkIjqPXW7KZ6xF+FWJ1FedwYgY1XW8bqC+o?=
 =?us-ascii?Q?bkhMCZidTwOnhmGpEIO/gXdl5hCZYZ/pyCd9UmGEhoRgetQ1HZgdN6Iva7Yg?=
 =?us-ascii?Q?cYorkPVbnpNYfPF5BfFBlFeuH/c/TbziZFsDa2KdzvMwQB9Vf/hCrt4+RlA5?=
 =?us-ascii?Q?uYK4ee3MrGl4cm4nU/J32Wt4nIz+oqbu8NFSM7gbcqjlNK0KkBB86k3IAerV?=
 =?us-ascii?Q?mu6/lGacamJ99rkhkmx1fAUI6ot3f6lTZ2Dnnrs2HvXvV5FQBaz38pedXJH2?=
 =?us-ascii?Q?xVk5E8ht596l7OhHGXyHHKkhFVaRm2WK4xrIhxj7kqCFx771Np03zrctaYZX?=
 =?us-ascii?Q?J/U9JU4kuEy/fgP9rZolsZ6amCnOw9sBNlhdbLH8OxcIaH1jK8N8+xYVzpK/?=
 =?us-ascii?Q?wVOL6fPLIZgVY6c/KaacfTkrEChZlCmB9UqhF9UzS+V8HeFBIkMhiGgKcdOM?=
 =?us-ascii?Q?K47a/sJSwBo2jTTn7zvlruBsL7R30txFQMtPigFVjULSU0LLX/5oMND8zhFy?=
 =?us-ascii?Q?758Gc/1+YKqSRff8d/lW+2WBq0r/lVb+mQCUD7+f0HERBmew2Ni6Xf8Rwtel?=
 =?us-ascii?Q?CzBWw8MV+53PIdn1TXQB1fuMpvQ+/pICsEuuxJdeqw8B1YmEqXlUju5WaIv4?=
 =?us-ascii?Q?sXOA26u/pvQnCzEZQALZWW3w/kbe+hH3DKAkHX5n/XQq1FyYuM4gSrjnaoPX?=
 =?us-ascii?Q?EJ0uT7MOWIL1iZ97oXpB45hbuPvWYGsV/aqRATerQn5DJvqq2KdXkFhO5eFJ?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e200faa-114a-4e7f-823a-08da8780b57a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:33:30.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVkuKr/w4ON3GQutEty7iArg/KfLR1+fr5IY5O15MKElbMZIRKQ/dbsjjTNC6N5JCb8HlgL1fEIrx8LIa8YqDvFkQPUJEOOq9s8b/sPdPyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260066
X-Proofpoint-ORIG-GUID: zrYbQg8SVIYnh9NSg3DDOVKShiAcQDm2
X-Proofpoint-GUID: zrYbQg8SVIYnh9NSg3DDOVKShiAcQDm2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Fri, Aug 26, 2022 at 7:19 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> >>
>> >> On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
>> >> > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> >> > >
>> >> > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
>> >> > > > There is a potential for us to hit a type conflict when including
>> >> > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
>> >> > > > with linux/tcp.h to avoid this conflict.
>> >> > > >
>> >> > > > Fixes errors like:
>> >> > > > In file included from /usr/include/netinet/tcp.h:91,
>> >> > > >                  from progs/bind4_prog.c:10:
>> >> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>> >> > > >    34 | typedef __INT8_TYPE__ int8_t;
>> >> > > >       |                       ^~~~~~
>> >> > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>> >> > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>> >> > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>> >> > > >                  from progs/bind4_prog.c:9:
>> >> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>> >> > > >    24 | typedef __int8_t int8_t;
>> >> > > >       |                  ^~~~~~
>> >> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24:
>> >> > > > error: conflicting types for 'int64_t'; have 'long int'
>> >> > > >    43 | typedef __INT64_TYPE__ int64_t;
>> >> > > >       |                        ^~~~~~~
>> >> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note:
>> >> > > > previous declaration of 'int64_t' with type 'int64_t' {aka
>> >> > > > 'long long int'}
>> >> > > >    27 | typedef __int64_t int64_t;
>> >> > > >       |                   ^~~~~~~
>> >> > > > make: *** [Makefile:537:
>> >> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o]
>> >> > > > Error 1
>> >> > > >
>> >> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> >> > > > ---
>> >> > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
>> >> > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
>> >> > > >  2 files changed, 2 insertions(+), 4 deletions(-)
>> >> > > >
>> >> > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c
>> >> > > > b/tools/testing/selftests/bpf/progs/bind4_prog.c
>> >> > > > index 474c6a62078a..6bd20042fd53 100644
>> >> > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
>> >> > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
>> >> > > > @@ -6,8 +6,7 @@
>> >> > > >  #include <linux/bpf.h>
>> >> > > >  #include <linux/in.h>
>> >> > > >  #include <linux/in6.h>
>> >> > > > -#include <sys/socket.h>
>> >> > > > -#include <netinet/tcp.h>
>> >> > > These includes look normal to me.  What environment is hitting this.
>> >> >
>> >> > I was hitting this error with GCC 13(GCC master branch).
>> >> These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
>> >> so does it mean all existing programs need to change to use gcc 13 ?
>> >
>> > Well I think it's mostly just an issue getting hit with GCC-BPF as it
>> > looks to me like a cross compilation host/target header conflict.
>>
>> This is an interesting issue.
>>
>> Right now the BPF GCC target is a sort of a bare-metal target.  As such,
>> it provides a set of header files that implement ISO C types and other
>> machinery (i.e. it doesn't rely on a C library to provide them):
>>
>>   iso646.h
>>   stdalign.h
>>   stdarg.h
>>   stdatomic.h
>>   stdbool.h
>>   stddef.h
>>   stdfix.h
>>   stdint.h
>>   stdnoreturn.h
>>   tgmath.h
>>   unwind.h
>>   varargs.h
>>
>> This is because we were expecting this to be used like:
>>
>>        <compiler-provided std C headers>
>>                   |        |
>>                   v        |
>>         <kernel headers>   |
>>                   |        |
>>                   v        v
>>                <BPF C program>
>>
>> However, if it is expected/intended for C BPF programs to include libc
>> headers, such as sys/socket.h, this can quickly go sour as you have
>> found with that conflict.
>>
>> So this leads to the question: should we turn the BPF target into a
>> target that assumes a libc?  This basically means we will be assuming
>> BPF programs are always compiled in an environment that provides a
>> standard stdint.h, stdbool.h and friends.
>
> Well for a normal GCC BPF setup we're basically cross compiling for the
> BPF bare metal target while sharing headers with the build host(for libbpf
> and any other libc headers that get included).
>
> On the other hand when using GCC BPF as part of a full cross toolchain
> we actually end up sharing headers with our real cross target architecture
> sysroot(which would provide a libc), essentially in that case BPF is a bare
> metal cross target which shares headers with the real cross target(which
> is not a bare metal target). For this libbpf is installed to the real
> cross target
> sysroot which is used by both GCC BPF(for bpf progs) and the real cross
> target GCC compiler(for userspace side). From my understanding with this
> setup GCC BPF will pick up the real cross target libc headers as a fallback
> which may sometimes have conflict/compatibility issues with the kernel
> headers.
>
> I think it's probably best to avoid depending on libc headers as things may
> otherwise get even more complex. You would essentially have 2 libc's
> in a normal GCC BPF setup and 3 libc's in a full cross toolchain setup(you'd
> have one for the build host, one for the real cross target arch and one for
> the BPF target arch).
>
> Cross build systems will typically allow a libc choice as
> well(glibc/musl/uclibc)
> and we don't really want the bpf programs to have to care about the specific
> libc being used as they are bare metal programs which shouldn't depend on
> a libc.
>

I don't understand what do you mean with "real cross target".

From the toolchain perspective, the compiler is targetted to just one
platform: bpf-unknown-none.  As is usual for bare-metal targets, the
compiler provides headers to implement the C standard with things like
floating-point types and standard integer types, `bool', etc.

If you then -I directories in order to "share headers with the build
host" or with that "real cross target", or to use any other header that
may implement the same types (typically a libc) then well, thats when
the problem arises.

I don't know how much sense does it makes to include glibc headers like
sys/socket.h in BPF C programs: I'm no BPF programmer.  But if it is
something to be supported, we will have to change the compiler to not
provide the standard headers.

>> Thoughts?
>>
>> >> > > I don't prefer the selftest writers need to remember this rule.
>> >> > >
>> >> > > Beside, afaict, tcp.h should be removed because
>> >> > > I don't see this test needs it.  I tried removing it
>> >> > > and it works fine.  It should be removed instead of replacing it
>> >> > > with another unnecessary tcp.h.
>> >> >
>> >> > Oh, that does also appear to work, thought I had tried that already but I guess
>> >> > I hadn't, sent a v2 with them removed:
>> >> > https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u
>> >> >
>> >> > >
>> >> > > > +#include <linux/tcp.h>
>> >> > > >  #include <linux/if.h>
>> >> > > >  #include <errno.h>
>> >> > > >
>> >> > > > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c
>> >> > > > b/tools/testing/selftests/bpf/progs/bind6_prog.c
>> >> > > > index c19cfa869f30..f37617b35a55 100644
>> >> > > > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
>> >> > > > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
>> >> > > > @@ -6,8 +6,7 @@
>> >> > > >  #include <linux/bpf.h>
>> >> > > >  #include <linux/in.h>
>> >> > > >  #include <linux/in6.h>
>> >> > > > -#include <sys/socket.h>
>> >> > > > -#include <netinet/tcp.h>
>> >> > > > +#include <linux/tcp.h>
>> >> > > >  #include <linux/if.h>
>> >> > > >  #include <errno.h>
>> >> > > >
>> >> > > > --
>> >> > > > 2.34.1
>> >> > > >
