Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB834FF528
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiDMKyI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiDMKyG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 06:54:06 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9B593B8
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Apr 2022 03:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649847103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Kvcir69ojgyOs3J+q+/Q6hDram9Vc3qOQ0eQOmKZcE=;
        b=ZnVWbdFfDE0hDmaSTOQlEqvRbYgSVJWZpnVVf4L8lyGeHa8d5RNE2b3u2gMligvkszUTcb
        03PFKTvJKlcFlbR/2H11fNXqzeQe0VlLkvPi2XWjch9ftCfvdYdr1fhGrJ0h3917DSG5pe
        QonvV5BT1hHCyhORFLnFX1kVbYLNfek=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-5BvojMXXODGuFplnEoD8Kw-1; Wed, 13 Apr 2022 12:51:41 +0200
X-MC-Unique: 5BvojMXXODGuFplnEoD8Kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkBeNHAeMDxT6qFabvIo72SmtaXQfqbCRk2EMTMjTyAmjmcOsE5MrfBCPBRb/M8klTKWeTJfnms3HoP8F4qT1YhMVzdOd1RcpG4IfWC3w3ChDXBf5r4anTg3KnEsu0ZWpKX30qr9XBKvzpRjjUxLo0nA9liVVIvl2/HTnXaLZWCPO/QyOmnW/SkBJUcZ8SKd02PtFPycsIwuilKc4u5GTNdii70x0l+QpZcqCthlzJ0P6QnIFoXsmx0laUeZiD53zBrO0g0lYZiB9COR755X/mrvpSioodeGaFZyHkvYgXbPFtCFu5drPHs4jJWFCJDxcmamZGDMubdBjEjYJmgq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kvcir69ojgyOs3J+q+/Q6hDram9Vc3qOQ0eQOmKZcE=;
 b=XBhTvYYa9XTQmMBfWgcIqGpAw99YLS76Z+V6+q2fZHFvZ6+41C1ZCEXVStBBCdQgtlQ/XYuJvwb3KcrVlWj/tL1QS6diOMFVCOjZNq2RjeDsLQtPbS7AxZf+Gb269Br0xSJqn9nZlwm1HwffbPccJrYshIPyX6vebkcOeV9HM56qtNUglHe7m5r52TUyt3BlW5Do2EQOumHj/G8QFtrKtj//C2lAVQzbvt9pb1lZq/cK//JUWlNTmZXankctjqnjr/xNM010EtdIZ17+zcaQzdKlWb+mXIC32mYKMV8KtqB9BpW1FchRI9xsYjkIc5MQJkd6Fmk/luVIYYvGWMM8Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6587.eurprd04.prod.outlook.com (2603:10a6:10:102::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 10:51:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 10:51:39 +0000
Date:   Wed, 13 Apr 2022 18:51:50 +0800
From:   Geliang Tang <geliang.tang@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: mqueue: drop duplicate min definition
Message-ID: <20220413105150.GA21318@localhost>
References: <cover.1649424565.git.geliang.tang@suse.com>
 <36201289cc9281ea7653127b0008ba01a1c14290.1649424565.git.geliang.tang@suse.com>
 <2d535cf6-d5dc-21fa-4456-d9fe06e9588d@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d535cf6-d5dc-21fa-4456-d9fe06e9588d@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0215.jpnprd01.prod.outlook.com
 (2603:1096:404:29::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2158b726-7718-434c-bfa8-08da1d3b967a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6587:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6587CB865241D43AEEC96713F8EC9@DB8PR04MB6587.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dpiLsQBPAjPbUlDHkGNvKazzbA5Gf8MA2Z/U3H/rpZYNn9l04KNGkeRYXxid5jeCifXgUpYZ2oy1g1XCY/pSmB0SOu7xl0G2MRard80kOdkgl680RdatTtrbpo1F9Z1+07ze6xntcVEuUgo9x5lbsfzgpri5diHrjYlaZ3wmD3e8YGOKDLT/Rm6AsLvjToktHbIMIsAsBeC5T3+bRrLd1pzEPF88oM/1zecRp+ATkKShc5BQiqu9dCmoWrAietpt3YzPhSxZ1J9HCjDyCND9rI4ma2j9WKRJ1S/hKBtOAAFI9fc8pJxHKlpHCsZ8XecoOOd3JCf7zSVLSszpCo/WrTaR90wkWOUkx8CpoM7a9x6CWX2ZcIABYMusqpd7TxXnd6V2z96pTqyqLgcAHoYXXRlMirp07vLV0RfK3Rx++04vflOQqHYtMgqf2Ng/CZdvk09QewvvjTax3z855BM4Yo8BJ4zqwq4P/ELKvjmjqryWfqHOTK/7plRAhpuO8EOlga7BmTyEVdXqiSoqmGHJW2p4x8t7R4yJ8Gg2ZaZKuZMKaIj8pvkbZVniC8+BeckRG6DOwCxz4GzR1mFVoAwrfum3dFaC9yS5p+NimRg5cbK1h9VjdLvXfPuSJLu1qHA4ph0x3cHiGIWvwd8DnCYZoMKB4wDb8R7SN3RWMI688F2AmoS+/2/+mFOn4+YDGzkkz1l45RgGtg3fdotTlCeAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(316002)(86362001)(1076003)(4326008)(4744005)(508600001)(33656002)(6916009)(54906003)(7416002)(38100700002)(186003)(33716001)(26005)(53546011)(8936002)(66556008)(8676002)(66946007)(66476007)(6666004)(6506007)(9686003)(6512007)(2906002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eChOvFbJysgl+swl/TMuq+lkFeMGbFusFOd8BLFS4T2RKYer58zy8eS4fOS1?=
 =?us-ascii?Q?8jruaGIpCFsOCu5Kl4bc/Pyjbcs4YjP6RPDD3AewsojBJ3YJS/suthguoqFg?=
 =?us-ascii?Q?oYisYsWafzFiM9N/jl2T0zbb0kj5xnYIKcmw+8rcANNN6omtpRvskrKidDAJ?=
 =?us-ascii?Q?wVTjGfhVhgIq6nAIevg4DxkVbRxEWL/n7uvq79dscCMHSchV1Z4B2BoBNFLL?=
 =?us-ascii?Q?+xnIGT04rThfEqshlJx+QIpkin5yCo8yTAL8/NyuPsPO0F+hwhp+KzyclWtk?=
 =?us-ascii?Q?vLLmUdebD+P8h/+CU4B0v5T87aj4QibSE9njxlNU0AzdRBKoIwQDVpH8z+Sw?=
 =?us-ascii?Q?vs6ky6DpSxHPlWePvq+58xpWyFddWXqWU+1Zn4NgkDQqrZ+H/1KdNhkJ5rCe?=
 =?us-ascii?Q?yJmmlR1AWQywtO2xCZFmHbmsqpS6wK9hjhxS1iLdqwE1PxPbMKISNLwnA30r?=
 =?us-ascii?Q?MA+tTeaTU5JsnVCbeCX1s0Q3RXc5WrH7II3dZCq7iAIu2hbIWOQ9kMwmnCBw?=
 =?us-ascii?Q?8BXmtAMwwihDfrZf1FfUzV/60gg8Ng4vpyzwlNa7MMBBPo7SFEbtSKgbkqKA?=
 =?us-ascii?Q?aMKxemUFEjxwN3cEWKojKojkJyOdsEqcKhUV/oh6xbwr3DSx54IUr0IXh0BA?=
 =?us-ascii?Q?jn7IZ7s66X3OD31HU7jAfb8RJUy5C0DdoF1D4htsrd4utRBiMO18ZQ1spO8V?=
 =?us-ascii?Q?x4gXFk+ZuIV8bQ/2SPDTb8Cg2OSfBzLK5306CebZcEMXHYQkMJ9ctDljVCQx?=
 =?us-ascii?Q?IPjBvFKpD6SQVCcJdgWGlpd8TInK7gU1AzjBKMj8Ml5r88Ssmu/vnpyALdte?=
 =?us-ascii?Q?lw4ENpMtskveN2MBWWTMzVvHkuLaogjN3n6NiPTXEnHhJ6iKdfFzeAOswD/w?=
 =?us-ascii?Q?pAZWTz7zZqNesVED/qn2u76bInTx1gLbYdOgcS+493FkhVP4zYOHBqnJzzHj?=
 =?us-ascii?Q?9GDqHIy7ot/q1VGFXFeX20KRXZ0DVNCMtiF0hlOkUVlukvRr0R4+ILASbIal?=
 =?us-ascii?Q?B/aztUS+KaPluCnQcNtsp0/K4bbOUF3RJkzRvd1E5QdeuC6vv3Hc6sSyUzbM?=
 =?us-ascii?Q?SXK7sutEXYzGPI3nqBSDYquSpXtZE0LXyooxP9wfox5q+ZvEkZSWMt8inCqf?=
 =?us-ascii?Q?Zu6rY5/5/egkF7Qq1ZqsS6V1bjZn7iJhDEAUPn1thAKdqeolrmlWH2J2O+pQ?=
 =?us-ascii?Q?t6KEOsYX3dnq/luaPtKVK2Jp32HQhW8yrmLmp8URYneXyaQYMudj1RR8tZ+K?=
 =?us-ascii?Q?I6PGc+dLhTjEt0LjQtsgz4vRRZZz2Pvtm4ySLuoaCHvkAyElWCObQi0gy2gp?=
 =?us-ascii?Q?j5Qcyv/y2dHzEOt/mnGN7t8dlbztwKYDnqHa+rDLaqr8RKtBMvu+T3qVacGz?=
 =?us-ascii?Q?6rd2zVk8TSK5IwK0lZpv7DPZq+TSDfY9NDu650Ob2H94jYf8lnQlVmLQI9dX?=
 =?us-ascii?Q?2FOXEyLbDzScinm3DUN2bGQ24hi8xQ2zHrFFdn97vwwv/F9Y8RHj2di74J6E?=
 =?us-ascii?Q?LVUbPAK9QezmMdTTa222hSAmXtBaL0+viE4pyDp/PonNCDSI/bwlyHTJCeTb?=
 =?us-ascii?Q?LOo1wYuKXXr8xLPJRzLcQ3fv4qrrXz7JcijUsXAG7SYl1O3X+4XmLvwDLX7U?=
 =?us-ascii?Q?a1BpFh0onWwUIhGu2pvlQMTVebHqgN3USWLt3gdEqlVpjNYMzoZLjytNDbiA?=
 =?us-ascii?Q?epjff6H2IWujngvrTYPddUsmuklVMjbIuonv4vjVTTiwwJvDuDaF9oc2OkRS?=
 =?us-ascii?Q?WoAiFt52X8VI5KkXTDLu2kDRL+BZqpg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2158b726-7718-434c-bfa8-08da1d3b967a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 10:51:39.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n60AWH/rwQGm4m321ZoZY8YL2W4eA0ufRRuu4IRK/mca4mgdoMGQTmAjuigV4MOsJApzHlGFzqufyc9GeIPlcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6587
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 08, 2022 at 01:23:52PM -0600, Shuah Khan wrote:
> On 4/8/22 7:36 AM, Geliang Tang wrote:
> > Drop duplicate macro min() definition in mq_perf_tests.c, use MIN() in
> > sys/param.h instead.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> 
> Thank you. I will apply this for next.

Thanks very much.

I had sent a v3 of this patch, but it's the same as this one. So apply any
one is OK.

Thanks,
-Geliang

> 
> thanks,
> -- Shuah
> 

