Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C15A2869
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbiHZNUL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 09:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344300AbiHZNUK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 09:20:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8B632D9C;
        Fri, 26 Aug 2022 06:20:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QBOjtI027016;
        Fri, 26 Aug 2022 13:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=LKrNRSbX4z8ufF5cHytmmLCAxBIjblW/PriBZ/g0eY8=;
 b=yYjVSD9CygvW3aI130xRZKQLKpKSwYMvD1BMSXIVNf/vvqV8aW+f52F1tPE9M9c1DbmI
 SO3SZnIDTal5v150f0WdX0/J9jdktsmRp9ih3WSEY2mvW5FYjDn9UDPKNI98xqV3lpo6
 zq7os7JFme9GJlSIcazVFTnbFpTO49kTEf/sEAJ9BMnUNpgaEHwLFwif8zKyTYy2seIU
 1J32U51i3L3dNl1B/a9QqijFeaKelmM9QBJNpM2EDvrP02gq86lRTttRX4X2yMSwqFcV
 3Aiz/ayVsJAwo2aXeo3TZgqF8aj7AIvG5st3M2vG0gGORyUmhUHM9ws8QoOR4cCW0Dhl Pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w25sdgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 13:19:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QDDK3u028504;
        Fri, 26 Aug 2022 13:19:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7d31qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 13:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQY+ZEq8NuPEhJ85mED05HDjZadh1qLumx/leOnTv3gIrPRVkzK8TH7jvwAz3xwIzg8Mrx/dz4bvh4d0A8nwRJeKdrQMpk7nGm4yECtiyCDQTWyiFGJU2pHmdw7v1MDw9E8v9Faaq7DHqHwNvUu0YYfFnjm/HFMtqL6vFfqOHfICuFvpgyCfGgP2bA0TrC+qkjpWhkYWlv1EMowvlEeoBjkV9tUr0RpSSaT66MR/JJszfa/YYC1IfY2zneR/lvgnXXVIsbmZw7S8OvNDdywo1pL/CTttgFKsEN+YvH+an+g4apq2A5wj6YoVZihGxoa+y61MJprsfOR2ALAFdhXyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKrNRSbX4z8ufF5cHytmmLCAxBIjblW/PriBZ/g0eY8=;
 b=G5n5aPsyWKjf7foKhElYhZU7EAqe45Ug1PSlwJD15mABIXB7g8Q42kVJ0jWr+26ayvBjhS6920BQimcxIrPoyLzo/RxPLOSxKY/60LvHqfqG+MEyqy6ZZfoFsn8XDllggx11B6m2ntan8fXwohmT2XKZbMqezgATQwmESROlJuh+2J6Z7qKTuvkwAIgdcemNgryba4Y6Cd8iPOLw15xUF/Q1+ca4wRxuv8uKCXobGkXfUcBb2oHNHPRZjAnJV4EUx/LQTZq2a668Hce4OK6fKOhU2eN2+jpH3AWVxNQfjRP2tYV1S9Sj8UbcH0/GeQ/RqZedTZBSoA6jjNy0ktcHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKrNRSbX4z8ufF5cHytmmLCAxBIjblW/PriBZ/g0eY8=;
 b=Z3X0CH2jSQiwteBlNC/3TaGj+SZg+/NdzOfQgHl2Bmqk9pIYQVObdZIuK1SHZhQ9FZ96tlV7cGs3zttEjSWHLYG/jN0S2DxCAMovH0jGRSfrm1GOvu4j/r+QEgR00cbH8/xH8M1/+l3oMx7GIu/1IgdQkXLtzQHEnTAZ7ExPcVk=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN6PR10MB1252.namprd10.prod.outlook.com (2603:10b6:405:e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 13:19:38 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::6440:83d5:754:2daf]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::6440:83d5:754:2daf%5]) with mapi id 15.20.5546.023; Fri, 26 Aug 2022
 13:19:38 +0000
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
Date:   Fri, 26 Aug 2022 15:19:13 +0200
In-Reply-To: <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
        (James Hilliard's message of "Fri, 26 Aug 2022 00:13:54 -0600")
Message-ID: <87k06vdtwu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4178588b-acc6-4118-c544-08da8765a01c
X-MS-TrafficTypeDiagnostic: BN6PR10MB1252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: US9habxjtwakw5YKgjjZQU0f2Qec6kKFeCA5nxZgSyIsnQg0z4Si6LdK29VYSYGmg7kXQtLxGu7GHXcbGic/6mUeZHEQeJYjXeflhAR1YVm8IvX6efVxf9EtvdFohVV7Gr17jMwiPwZQEKGFqMuLDoN3cJlrkhg+VZZnhqFLvuaA4wG0VL5iaYg89RGHu/syUCtSUXuCwr6Rh9KN7nNsDbngkHghcAsi3W24m2NzJgkVasHqt0rIVVz5WjFW1AqUSQCoS5lKCfVJnrMHRKkqAyPJjzLNWsAwdGnB+pzyG36DLZ3iTDZKFTk1GM7cPEfMQM2Yo8aYYy/TUZgsQZRgSFru8QCaPxhpQ3T8H3VYlOjmFQurGW+dYjf4bA6TGLGmBmpEpylSGkvsOKDDmIVlZ/QMEtFQupOSiIliysmAz/C8cy3o7ZscMQLgjZmP8Sm3G1lt2P+psOzYvyW6xCnnRrbqTpI8IB0+fIsDGdou4imXmo1ItkXy5K6GqKyqC8NUOSKr6ytc1d6Z4iWfrZjpvOs24dIMYiLKoAuTtU6fJhM/WIs6JzywBTE1/XvC++QznylzC7SkmTFOXLodIoP2VS6yQlEp/N21hP/frL2t5WbJ4OdzYkfDAghpNfgWSRHWavTKKARJMm8gRD+B+oqkdAK0R3rw8RXJClPYn4B+Gyvbaw4dd2Geig2KXm3YQvUbo0Ha9xBT3FkBrwKcEbzBGkzOGeTf6d2HINqvN2Jg8uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(376002)(396003)(366004)(2616005)(83380400001)(7416002)(5660300002)(2906002)(66476007)(66556008)(66946007)(8676002)(4326008)(107886003)(6506007)(36756003)(186003)(6512007)(6486002)(53546011)(966005)(26005)(41300700001)(478600001)(8936002)(6666004)(86362001)(6916009)(54906003)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m/oSBMqE9toGwHg8KU4kmeYDw5R7wm+//fle3Hhgsp4oQyN0rrjxGe/xs9LU?=
 =?us-ascii?Q?RHk697knOIK4zjFvFexPpYTV05tYHGZ1NtEnRcB6pQlk9qr3jCqOWo8wPz7Z?=
 =?us-ascii?Q?17tjMO3W8lM2gYgQKOCIzCvF3az98WOdEI8LIW53kXl0hEFSRM5U1Lr9nqkV?=
 =?us-ascii?Q?6Rq/rShs+Ao2ShTv/TQpF0VzHkAAZq6qa9AECzZxCIguoHiB33Xjjbel+ZNt?=
 =?us-ascii?Q?DZ0LSMZrcaF6KJbAChGFWj9Os4xL0YZFJCc67gyhv2XNweFPSMo+Z3pAHcJH?=
 =?us-ascii?Q?f9AnN1aFcYrIAgh1f4krYtmnZy1sl6tHtPYSNYOR4sbZiGAIHvlXnQzFjkYT?=
 =?us-ascii?Q?XocqnCmtzzooUCAqkY8z7Th2hSHyH0p+Byhf5hjdkFstvwowGCdTt4GzdZZy?=
 =?us-ascii?Q?uko8qbeSoPYq7Xk833JuDSGIulVvacRoIqwH3swZH24kNM+O3okppN0x4+QJ?=
 =?us-ascii?Q?3WtPXSKaqjRO6qYVPICUcJgfP0vG/7dVEB1LWBK4xJRUd7HyGBF4dSql/ODP?=
 =?us-ascii?Q?ha1sp4rw5QCDFBQnOeOQ+d2icGtqw8P1ughdlB9Q6rE+OI34iAZuIhnjcHnM?=
 =?us-ascii?Q?wSUeRezh2cpjdGEkpHDOg1hDnsOREPl/7HBJWA6Un2UW/3MEJPggsSVp7ifm?=
 =?us-ascii?Q?R4K69D0yE/CyPB8LqlhRfgvMEC/ItYNmqqnK+MTPAGOczNWxsJaSegekGBvq?=
 =?us-ascii?Q?ybw/bpEbSxRPJg+IOngqZRc4NcJnhBf7eeu3YOG3fYBa6sBXPNa14PD30ZIP?=
 =?us-ascii?Q?Gp63F9Dhj4LZMvOJQRauZw0hwk6XRH7DPmFj7pDGSrSzVusGcQtU66B8pYjt?=
 =?us-ascii?Q?uEbbijnob2Vuc41CyGW5JShTfw2Bjag6tFKGu7DRz3B/zpSrI9ernfTyKpYw?=
 =?us-ascii?Q?9259zT0nX7sT1odBCsZKutcaEOAa/whUEQRdPqhE5S3h9jgvqvevrn+VaYGP?=
 =?us-ascii?Q?ef0HXleH38t8qTpoiFw7dJeW6NBNV1d15+bMOT5P3pjhjsl5b4CP926fkk0M?=
 =?us-ascii?Q?CcUEyPAsPO1b90640m3paxe4X1Xc8/ZGDb+pG/tQvW631UYMJrbx1CRhFTIQ?=
 =?us-ascii?Q?/Rodgzna7NjxL3nErdPEeWMmBmoxQTydrgblRobBBXOtMzgWpGdJAP8qyAF0?=
 =?us-ascii?Q?qS6qP0lG/PsT498OwWhymDgzIfBFgofrjYbB14XJB6vMbfd9v2EMofUl7DgP?=
 =?us-ascii?Q?hbkhto5ScX1/rxj8hPKByWRNa2lNW3hxGW/u+oSO1zlHUrfd1JrfXZ1sntZS?=
 =?us-ascii?Q?bS4DYAPlhcg74qBEDJZ/oe9hKqKLuq48pvnRTr6T14SGHAykh9pq+LW+0E4y?=
 =?us-ascii?Q?Co2ugUFptGOd3L9ILRXKJaR8Ve7FLYBQWYTk3b+G+bO5eHyb+TkFSVB9skoI?=
 =?us-ascii?Q?CUFuYi4yDS15eXUlGZVDFuoDYMs1UhMJfSwFMBi9QE4ufsurOMyftlO9KEki?=
 =?us-ascii?Q?+9gWgIgvfQkYjo/0tl4llpXJ16Cvi7dwTpVgZ+NL/nuO48IxrlApecN+FA1h?=
 =?us-ascii?Q?TpwqsQaUuN7ZnbhCXqGj6cjC1ddfTj0U6KAx+9VbMNPUfDqWL1OHLaFFgMLO?=
 =?us-ascii?Q?RHEeSdVJXcPdZPaI58wwVdnpRZ/1CVpiX3DiJy3oIOhlfukrF/0BGJlBVUwA?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178588b-acc6-4118-c544-08da8765a01c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 13:19:38.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtqfVPFt/gSQTB0RXHMP2nYmzgPNKS3A/NjJ9BFT43UCKL+ycTQh0y/86Awlxow9hYXeV9yTDep8FpTxssNqf7H9iQrR1allwyHuYBjG01c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260056
X-Proofpoint-ORIG-GUID: VG9JgY4BU5h-r_VMc3ncsn62hpJ5XHDs
X-Proofpoint-GUID: VG9JgY4BU5h-r_VMc3ncsn62hpJ5XHDs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
>>
>> On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
>> > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> > >
>> > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
>> > > > There is a potential for us to hit a type conflict when including
>> > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
>> > > > with linux/tcp.h to avoid this conflict.
>> > > >
>> > > > Fixes errors like:
>> > > > In file included from /usr/include/netinet/tcp.h:91,
>> > > >                  from progs/bind4_prog.c:10:
>> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>> > > >    34 | typedef __INT8_TYPE__ int8_t;
>> > > >       |                       ^~~~~~
>> > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>> > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>> > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>> > > >                  from progs/bind4_prog.c:9:
>> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>> > > >    24 | typedef __int8_t int8_t;
>> > > >       |                  ^~~~~~
>> > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24:
>> > > > error: conflicting types for 'int64_t'; have 'long int'
>> > > >    43 | typedef __INT64_TYPE__ int64_t;
>> > > >       |                        ^~~~~~~
>> > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note:
>> > > > previous declaration of 'int64_t' with type 'int64_t' {aka
>> > > > 'long long int'}
>> > > >    27 | typedef __int64_t int64_t;
>> > > >       |                   ^~~~~~~
>> > > > make: *** [Makefile:537:
>> > > > /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o]
>> > > > Error 1
>> > > >
>> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> > > > ---
>> > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
>> > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
>> > > >  2 files changed, 2 insertions(+), 4 deletions(-)
>> > > >
>> > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > b/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > index 474c6a62078a..6bd20042fd53 100644
>> > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > @@ -6,8 +6,7 @@
>> > > >  #include <linux/bpf.h>
>> > > >  #include <linux/in.h>
>> > > >  #include <linux/in6.h>
>> > > > -#include <sys/socket.h>
>> > > > -#include <netinet/tcp.h>
>> > > These includes look normal to me.  What environment is hitting this.
>> >
>> > I was hitting this error with GCC 13(GCC master branch).
>> These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
>> so does it mean all existing programs need to change to use gcc 13 ?
>
> Well I think it's mostly just an issue getting hit with GCC-BPF as it
> looks to me like a cross compilation host/target header conflict.

This is an interesting issue.

Right now the BPF GCC target is a sort of a bare-metal target.  As such,
it provides a set of header files that implement ISO C types and other
machinery (i.e. it doesn't rely on a C library to provide them):

  iso646.h
  stdalign.h
  stdarg.h
  stdatomic.h
  stdbool.h
  stddef.h
  stdfix.h
  stdint.h
  stdnoreturn.h
  tgmath.h
  unwind.h
  varargs.h

This is because we were expecting this to be used like:

       <compiler-provided std C headers>
                  |        |
                  v        |
        <kernel headers>   |
                  |        |
                  v        v
               <BPF C program>

However, if it is expected/intended for C BPF programs to include libc
headers, such as sys/socket.h, this can quickly go sour as you have
found with that conflict.

So this leads to the question: should we turn the BPF target into a
target that assumes a libc?  This basically means we will be assuming
BPF programs are always compiled in an environment that provides a
standard stdint.h, stdbool.h and friends.

Thoughts?

>> > > I don't prefer the selftest writers need to remember this rule.
>> > >
>> > > Beside, afaict, tcp.h should be removed because
>> > > I don't see this test needs it.  I tried removing it
>> > > and it works fine.  It should be removed instead of replacing it
>> > > with another unnecessary tcp.h.
>> >
>> > Oh, that does also appear to work, thought I had tried that already but I guess
>> > I hadn't, sent a v2 with them removed:
>> > https://lore.kernel.org/bpf/20220826052925.980431-1-james.hilliard1@gmail.com/T/#u
>> >
>> > >
>> > > > +#include <linux/tcp.h>
>> > > >  #include <linux/if.h>
>> > > >  #include <errno.h>
>> > > >
>> > > > diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c
>> > > > b/tools/testing/selftests/bpf/progs/bind6_prog.c
>> > > > index c19cfa869f30..f37617b35a55 100644
>> > > > --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
>> > > > +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
>> > > > @@ -6,8 +6,7 @@
>> > > >  #include <linux/bpf.h>
>> > > >  #include <linux/in.h>
>> > > >  #include <linux/in6.h>
>> > > > -#include <sys/socket.h>
>> > > > -#include <netinet/tcp.h>
>> > > > +#include <linux/tcp.h>
>> > > >  #include <linux/if.h>
>> > > >  #include <errno.h>
>> > > >
>> > > > --
>> > > > 2.34.1
>> > > >
