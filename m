Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99975A335A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiH0BOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 21:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiH0BOf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 21:14:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79465C9932;
        Fri, 26 Aug 2022 18:14:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27R0dABB029686;
        Sat, 27 Aug 2022 01:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=QLnb3HDEbQX+XS7OWNcvU/SiY0tkiTLgzoKFEvSmKq4=;
 b=aykRo8aJaTrfpfy9G6+ZpckeFV1nhS2udtX+uMHcY6AXdQvayDneGW5NnMW4G/ATMeZh
 HWQ4ukmevKpyNvrR0xcD411pP1Mc4J4Sdf9kmTRspGqhepUaGfPKqgF1skd+J8QeIfoh
 V0d5TZEKuBgm7ZIsEIs6uTQjPKxw9udI4uN2+35rGuyp5RcjICc8MQIReW0tOxu3S/Fx
 ZfnwbfmCa/y0LvQCOTQr1TlPwCiegwvgY52e6luviIHXg4fxmG9fo8qF7qIIUyB6uHpt
 SdMxibj8rOW9ZwoVfk6tA3zwN7u4Fz2velrj+nuine7jAN5UVJfEHA2zKTzqYgJ9VU02 Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww8bmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 01:14:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QNvEZn005020;
        Sat, 27 Aug 2022 01:14:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7dw8ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 01:14:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNxxLu+VjqFoAzmPL/z5fdKZ0mF41h83JfLUVrVWV6/uZPt52loZ7TEwZmEA6IIOlj8W1CK2y488VC6+QIKKaBT2qDMsA9Si+gTX0viPfxwhyS0lLaMwDsrRLYzGyS1KDxDvCDuR3TeMXE9TejLhpba9HDn5kGx6K1WMTSKI523fMvtSnGh3uy1MLbCDWEEvKdpnpdKTwMcdijYHIlId0WlvfsVwfvWvKrIyOKzkYhpkDMsLxUy6Ln02YuY0W6xo6vyztfqEKcaOckg/fRjA0OMww7nfG4TRiRJrVe++1Cct9kdFr7WE4adAirIweEhlxof0JexCth6XdZLYzDhQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLnb3HDEbQX+XS7OWNcvU/SiY0tkiTLgzoKFEvSmKq4=;
 b=e0qHdmiImJqbwC70tlwiJXpxSJE1ZGdlumN4rt4+kTyN8gzHDEGuhEZWzV6skpntEovoXg3hpYlZc1877d8ilaAfKL2oEnQx3sar3KHYGhATzuOSFLaNuEDqGMJZx1KOMuWNIdNiuS7IwghYXwLnRF5qpCkPeAIZfDfOY1uELEBTOW5iByGVEfwcHH8kyE8YmYVbD35JTAOKZl39NMMieM8nquB9Dt9HsYnHPnc248+AxyDFiDJE7Bzp8rttfBMs1LlMzzFz3mlNwn2qvm6ZGSX+MMhWJPk6DxvXJlXCGYdvTEJhajDjv1Wtzi6SRj0VvCPZtruhSZuXuhFqF644Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLnb3HDEbQX+XS7OWNcvU/SiY0tkiTLgzoKFEvSmKq4=;
 b=urBcsJv7X1jlwz/JpoDQFgCvSvt7nxIvcpTmmW8Ui2ISYxZoG9iW4SpnxB8MtoI4q6BmIJQ+lth9tj6ZS/7vzxuPD5dSu+yyQlQLb/QxHv11XYu2JWRHCcBwDAoyBe0Cy5X1aw143ZpIhETzuAaRjGVspH1tNWxKjx2A+VPv4Qo=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BYAPR10MB2933.namprd10.prod.outlook.com (2603:10b6:a03:88::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Sat, 27 Aug
 2022 01:14:06 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::6440:83d5:754:2daf]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::6440:83d5:754:2daf%5]) with mapi id 15.20.5546.023; Sat, 27 Aug 2022
 01:14:06 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Martin KaFai Lau <kafai@fb.com>
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
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
        <20220826051630.glhrbdhiybtqwc4p@kafai-mbp.dhcp.thefacebook.com>
        <CADvTj4rQdnd=V0tENFGCTtpTESwSCcwK+h3i9nZ75M+TywNWzA@mail.gmail.com>
        <20220826054944.5bcx7unsyx4ts6ok@kafai-mbp.dhcp.thefacebook.com>
        <CADvTj4qNR+m2fQMMf9+=hMruhon8G_7yFC2_43-qhZ9X7ZW=8A@mail.gmail.com>
        <20220826171741.pdiqa4n4mls56bw3@kafai-mbp.dhcp.thefacebook.com>
        <CADvTj4qg6R9udazmGFoFhn9pXN6HOqLGEsQOhCAELi1LxzoTmw@mail.gmail.com>
        <20220826212550.mgugz6fomoqpgdbb@kafai-mbp.dhcp.thefacebook.com>
Date:   Sat, 27 Aug 2022 03:13:41 +0200
In-Reply-To: <20220826212550.mgugz6fomoqpgdbb@kafai-mbp.dhcp.thefacebook.com>
        (Martin KaFai Lau's message of "Fri, 26 Aug 2022 14:25:50 -0700")
Message-ID: <87k06ubi9m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eece4dd2-5a02-4a5d-9495-08da87c96fb2
X-MS-TrafficTypeDiagnostic: BYAPR10MB2933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fi8XQFrtBXV32oKyfSyj6Yzy8oWEv4CYpHkp5PlMK38VBzizA8HsIoiDcGfx1EDRAM/WWS+/bntAMX0czgaMQxU+yO/Ie7Rs8zHU4GTMLj/cCuKIrM/XwrvzjDBX/lHH5bNrng+ANHDpfM3be2r/+vIrQgIWon2Zy9bR8S7FF7obDlyNuX5qFeK0ekd0uibHod6kHqUiUz68xU4NjeEAugpkPKGHADDteD5nsfg2UkzfepvvS7/z1Bf/uyKrF9aQc+DQVgub9kGbHBzgqKyXdBjwb6TYecWAlhjqt0T8mRegfuQuTV4rCkgmV6aeRApnT7GxFX7iABujaIEIUNnK9xDEhL5tahz2phM3VCgTbpOOaUNqtrdha18jYhzwtZ7ZTtAWKU7NP9Ghdq9Z2mE3spW3s/6wQHVb4L7GzGwaQZIs/HetqrFjicIi7bZm6Ymq8sjAtiovEtiNahRLMxoYel8DINBqi71TJfQc6zSmc3S5QAdI55zjCyCCV7BHHRvbVYC+rk9FpwXHgxhVoybY8beFxXCfINtakTHoBscq5jV/Hk9uYs0nyG931RXcVvWW5XIhACvX+Q/yuZ7WiWS5UV1J7QOqfsZg7X2AAfkkS3Ja/dTH5MhRmWjQZqWvG3ZdgeMzvbMjPCqa0rlUToUAcxqnhzXIZN7byBhtII+VJFpSEDN1epzext2WiUrc+oE7nm5u3+kZSqYpPkBSVK0t3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(376002)(136003)(6506007)(6666004)(53546011)(6512007)(26005)(36756003)(86362001)(186003)(2616005)(41300700001)(6486002)(478600001)(83380400001)(4326008)(8676002)(66946007)(66556008)(66476007)(54906003)(6916009)(316002)(38100700002)(5660300002)(7416002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ABV273+l+jeML4JsF5gIxsXw7hoHBBJWYGrYtlsutwXuCkXTcBIjv8GzR09I?=
 =?us-ascii?Q?ZD0jalkFbrq1ZBAhBZswMYLLr85XeP2o/x6H8PviG6lg3urrXgrroK8VXU2V?=
 =?us-ascii?Q?/CWQATiOTHonPYomg8t6V9RdnJ8BSTHvYprcLHtvxDNzZBCtkws910UqMr9b?=
 =?us-ascii?Q?5n/Dp5m5X9N+zeU+7ksWpgdo0fa0O08pFY7OJjWDXI9Z+KyoM6/dVEG3jlh4?=
 =?us-ascii?Q?rEmmfgyijFGdqY46AheNyCR4vIPnkWsAER78QHaYTv75HEqFPNnCV5h85LXY?=
 =?us-ascii?Q?aTCEB+Eyo03ig2OGUen7PFROsiiJwj6Za8PncJuwuL/1g8KFhyvSTdf6W1ZS?=
 =?us-ascii?Q?sSV0C3dXewSM/6DSi9MCH5Rn8ofLFWi8m3BG6IcONIr90+P1da93UeTgn37X?=
 =?us-ascii?Q?gFqUA9sazqB2UXNbay8+Brvnl/8eSG0pkcEoR89BQU1Nn5MbltS/T8L05J21?=
 =?us-ascii?Q?R5x7BSWbWxnqwzuFPNa0EDu1WLRAttlBZUYfdZsIA4x7n5KZAAdABBtyZKU0?=
 =?us-ascii?Q?eUdiIVxBY6mvnADaYc4vYbEUjyrecz5u8Qq6HMDHLzKGWysQyoURdynlVljF?=
 =?us-ascii?Q?430qpmfOQqgUuARhNaw92ytWjwQ+0O0jgDVL5GJ6BLc6S3WxTvXYCNiX5O0n?=
 =?us-ascii?Q?O9Y0ZXOEomVwzrvVnWPgiPfTX2KftdZEJaLSG53vD8ilrq/i1I8rDNKhsySX?=
 =?us-ascii?Q?FZ83bHRb379gaMkVirxIDWE2F8dsJTwEs6oCdVp9W8yxsaOeqNxDMMfiO5pm?=
 =?us-ascii?Q?npZl+iKLyXI/fnR1VoSpx5SgQF4WyVdxs5hUFwBeokaARZmAplwcKTGV280L?=
 =?us-ascii?Q?doCi5Ett8Y7XO2pVkcXtG/zGSPapO80WYhEruc8Xh7Bf5qRk1MBFmY5Uf4bB?=
 =?us-ascii?Q?e3kEUyWwY53U1htZLC5F1xRdRGf1EAAQ0ka1BYp96sCYlLJc3HmzdHUrQCiC?=
 =?us-ascii?Q?Ahh6fJRccxfq/4BMk33yNghhDwxLAATQjBG1K5mJgEeHxQT8CfBz7fyON1RZ?=
 =?us-ascii?Q?/Sfl6KhTj8iI3Sq0tm+eNyS9q3MvxXVwr68tyJoemNKqFZHxLCcB5E6P5ZxU?=
 =?us-ascii?Q?gx2cRpe0hSE7/hspdUKjrqdgc8+mFgAKV8qRVkbu5OXKFqbygIawAw5qY6au?=
 =?us-ascii?Q?ktFomaNWX+4Lx+ZrdqW+doeBBQNhLqN5oX4K7QO9lXcxx+MgDqEcsQk660gl?=
 =?us-ascii?Q?Cv4Z3Me+66hEr79uFydEvsv20klo65xuSea9TjKjBuuUwbikolCD0awLWB0h?=
 =?us-ascii?Q?Am9gWiPmTNP26cvjGTgyx2v3wA2ZbOCuxR0fu5TKs62v1DQ1oY/HWCaQ+aiQ?=
 =?us-ascii?Q?TQLlfX5kSFcAbutygpXVPVcGxdO5pMzKc03Nt5UvTjuW68rAaaXIFQsfZcxD?=
 =?us-ascii?Q?OlqxSxS/nZU6Xq14X7OEPpafIipV4WpfdEPkkVqIFZH42t86hwrsFq6tqiXe?=
 =?us-ascii?Q?R2Dl4f2wvqoch/EJlNGu+nhRpU3lOM+VFz4Warv21PqESHcUprIVe9ZUIBLW?=
 =?us-ascii?Q?D8TC2H4arL6eMVpe3LumgnqyBNluHc2XWkiiwX9TlePD0SezkM14JKHn7iPG?=
 =?us-ascii?Q?d+JviDtaeoAYjppoTyXi2qmhKy8rw0jFGAugC4jj9CPI4G+MwhsiijEE6uUx?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eece4dd2-5a02-4a5d-9495-08da87c96fb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 01:14:06.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llQMG+ngRH5k8BRNsAZkShq9kYBs1AQQChqIE876EAQQgmqwdxHasuZhjAiBHn653T7DNYFPm6uzYPHO230uftCRl1LknC66FuYCFUo9SQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_14,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208270004
X-Proofpoint-GUID: yd4eDkGAwAsLJG5DaghP94MOv-pNOqoG
X-Proofpoint-ORIG-GUID: yd4eDkGAwAsLJG5DaghP94MOv-pNOqoG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Fri, Aug 26, 2022 at 11:42:10AM -0600, James Hilliard wrote:
>> On Fri, Aug 26, 2022 at 11:17 AM Martin KaFai Lau <kafai@fb.com> wrote:
>> >
>> > On Fri, Aug 26, 2022 at 12:13:54AM -0600, James Hilliard wrote:
>> > > On Thu, Aug 25, 2022 at 11:49 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> > > >
>> > > > On Thu, Aug 25, 2022 at 11:31:15PM -0600, James Hilliard wrote:
>> > > > > On Thu, Aug 25, 2022 at 11:16 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> > > > > >
>> > > > > > On Thu, Aug 25, 2022 at 04:17:49PM -0600, James Hilliard wrote:
>> > > > > > > There is a potential for us to hit a type conflict when including
>> > > > > > > netinet/tcp.h with sys/socket.h, we can replace both of these includes
>> > > > > > > with linux/tcp.h to avoid this conflict.
>> > > > > > >
>> > > > > > > Fixes errors like:
>> > > > > > > In file included from /usr/include/netinet/tcp.h:91,
>> > > > > > >                  from progs/bind4_prog.c:10:
>> > > > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>> > > > > > >    34 | typedef __INT8_TYPE__ int8_t;
>> > > > > > >       |                       ^~~~~~
>> > > > > > > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>> > > > > > >                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>> > > > > > >                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>> > > > > > >                  from progs/bind4_prog.c:9:
>> > > > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>> > > > > > >    24 | typedef __int8_t int8_t;
>> > > > > > >       |                  ^~~~~~
>> > > > > > > /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
>> > > > > > >    43 | typedef __INT64_TYPE__ int64_t;
>> > > > > > >       |                        ^~~~~~~
>> > > > > > > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
>> > > > > > >    27 | typedef __int64_t int64_t;
>> > > > > > >       |                   ^~~~~~~
>> > > > > > > make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
>> > > > > > >
>> > > > > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> > > > > > > ---
>> > > > > > >  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
>> > > > > > >  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
>> > > > > > >  2 files changed, 2 insertions(+), 4 deletions(-)
>> > > > > > >
>> > > > > > > diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > > > > index 474c6a62078a..6bd20042fd53 100644
>> > > > > > > --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > > > > +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
>> > > > > > > @@ -6,8 +6,7 @@
>> > > > > > >  #include <linux/bpf.h>
>> > > > > > >  #include <linux/in.h>
>> > > > > > >  #include <linux/in6.h>
>> > > > > > > -#include <sys/socket.h>
>> > > > > > > -#include <netinet/tcp.h>
>> > > > > > These includes look normal to me.  What environment is hitting this.
>> > > > >
>> > > > > I was hitting this error with GCC 13(GCC master branch).
>> > > > These two includes (<sys/socket.h> and <netinet/tcp.h>) are normal,
>> > > > so does it mean all existing programs need to change to use gcc 13 ?
>> > >
>> > > Well I think it's mostly just an issue getting hit with GCC-BPF as it
>> > > looks to me like a cross compilation host/target header conflict.
>> > The users have been using these headers in the bpf progs.
>> 
>> Users can migrate away from libc headers over time, migrating away
> imo, not without a good reason.

Something that may be a good reason is that there is no BPF port of
glibc (nor of musl, nor of newlib.)  And given BPF's restrictions as an
architecture (no more than 5 arguments supported in function calls, etc)
it is very unlikely that there will ever be one.

Including certain libc headers may work well enough, but in general when
including libc headers you risk dragging in x86, or aarch64, or whatever
architecture-specific headers as well, directly or indirectly.  C
libraries (and system libraries in general) are targetted at particular
architectures/ABIs/OSes.

This means that the same BPF program may be using different data
structures depending on the system where you build it.  In the worst
case, it may choke on assembler snippets.

Thats why the GCC port offers certain headers to provide standard C,
like stdint.h.  That's the usual way to go for bare-metal targets where
no libc is available.

Again, we will be happy to change that if that's what you want.  In that
case, it will be up to the user to provide the standard definitions, be
it by including glibc headers targetted at some other architecture, or
by some other mean.  Not that I would personally recommend that, but it
is up to you.

>
>> shouldn't cause regressions and should improve reliability.
> May be I am missing something.  I also don't understand the reliability
> part.
>
> In this sys/socket.h as an example, what is wrong in using
> "'int8_t' {aka 'signed char'}" from libc and the one from
> gcc "'int8_t'; have 'char'" must be used instead.
>
> Why LLVM bpf does not have issue ?
>
>> 
>> > The solution should be on the GCC-BPF side instead of changing
>> > all bpf progs.
>> 
>> I mean, GCC doesn't really control which libc is available, it seems to
>> be a bad idea to use libc headers in general as they are developed
>> separately from GCC and the kernel/libbpf.
>> 
>> I'm not really sure how one would fix this on the GCC-BPF side without
>> introducing more potential header conflicts.
