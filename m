Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190A447936C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhLQSBW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 13:01:22 -0500
Received: from mail-sn1anam02lp2042.outbound.protection.outlook.com ([104.47.57.42]:7121
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230432AbhLQSBV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 13:01:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd2gW2/CCK+jdfJcUi4GMKENhdTtTmAIAVF8Cx8qGwvXJrt1mYBtNgteuKKbABYqfrEis/sA8GRqUmFGY8EPAfpujcpeAj9CK7464dK7L8UPe6Nbbez59S7iuNUecEWkSSlKnuIBT+JPIpV75lRTjELRjaVa9RO0WVnoCT5x73EYaImto146susvrPrIzVfypL54sKAOoBzvBF+tkDHewxT3P//p0Fx9E2FAQHIeZF4gJmXjB1zBQPoifbMHFj9GzVfBs/kt+SmX2r8Te+E8NsJOFNy3BUyPbWWlUFZBx/DZsDZusrIPnalRAlMQvtzZsdCcSAvRGhXn8hREHWKMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCXHB2tKprwWILUuPpBGqZik93yfVOfH3s1IvFDddkk=;
 b=OZIYX/PhundqfgqZue2eO60rI86LafRb9pbRDYoXwHNAnY0+V8PRr9FViMb6pMaTpCzL+H25BNXBlW+fnmn9/yu+TKXdIRmibf7Lki0Ek1IsOCPl/RkCIZ8ejNC2y3N2tC9ojkn9yXJzlMNh84lCiqY1gxFaV/J0KqYtg0qlBuKYdvpi8OA2du2BG+hgSgiLLKSzMUPLsIVL7bIbeyEgurFGno4NlhJypab+NmXUxvaQaJbfwt2jG0mDuZcz0YAzqKT/YNMplbac9pnwyQnfcgUJGwGMJ4336I4veMgGR6GW7xjJtFUKAOmiYDJFu9TYov4L3D9f3TI7YecsRIUgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCXHB2tKprwWILUuPpBGqZik93yfVOfH3s1IvFDddkk=;
 b=xb9SBD0FqRsqLhJA+6/nT0H6ka0wIDcM/DXGebMHEhUQ9YPNSi3eFKma1kP1ZTXiy8HtAkxlNb4XhiQ+etPCtEdM+WZGGP/Wp6TvfhHgePAtKSpeFtyitgx4iIYOG7JpDpPEVI/UC5LdFGFKKOtAuPGlW2xMFMap4lrERMWV6YY=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CH2PR05MB7143.namprd05.prod.outlook.com (2603:10b6:610:47::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.13; Fri, 17 Dec
 2021 18:01:17 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Fri, 17 Dec 2021
 18:01:17 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 01/11] seqlock: provide lockdep-free raw_seqcount_t
 variant
Thread-Topic: [PATCH v1 01/11] seqlock: provide lockdep-free raw_seqcount_t
 variant
Thread-Index: AQHX8znaqyMNBisG2UGD/gNtIc+9Gqw26UMAgAAHdICAAAXPAIAAAzIA
Date:   Fri, 17 Dec 2021 18:01:17 +0000
Message-ID: <3F35C81D-34DB-4EA0-BC5C-A13EB71524A4@vmware.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-2-david@redhat.com>
 <38BCB153-7E7C-4AAD-8657-E5C6F9E1EF9B@vmware.com>
 <058e97eb-1489-3d59-c6ee-94175dc13134@redhat.com>
 <a832ca37-b078-6f62-f99f-b2703674c1d8@redhat.com>
In-Reply-To: <a832ca37-b078-6f62-f99f-b2703674c1d8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9517d1e-b9b4-41a3-11cd-08d9c1873927
x-ms-traffictypediagnostic: CH2PR05MB7143:EE_
x-microsoft-antispam-prvs: <CH2PR05MB714315DFE9FB5309A2EAC302D0789@CH2PR05MB7143.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkm08M6/r11uQ3quYuV2Ne+kIXZsk6JQpfWkSAgElLHmez5zu3qdf5hSH019ZBT+TPS6bbHP+ntMUa5Vrxe4LniaPkbjulzD7HMy3tY8m4Mi7y2lgGNsrpdBe5Av1a1KgtGmtc04DPEjxWCTVqdvmz/TPGw2gtzLrwkhFS/sPyxmyQQiLFNpf5wvrEbwEtxUrvUJIwIqcEm0hJ4S8Bg3XYSd97sZYOLp6hDN4WdQDhh0PYXZKuXItNGeFx9lKgi+zOiLevptaEN/6UCYs3xstKvKMv2lCsbHY142/+4UFQmYOMuGFEFcFuAOERgXLVTPYIOSZPVXCFbtrUhO78GdG/nsHKPtPk2vqdUaOC5FNHjB0JxLebX6YWaG0uKeFtdCtyqk9eUpblQpH50kaywt1eYFSqJViH4JhTqK+AflGLPS8oT+nvZ65pfPPT4MkhOPN5JjWMrgIH542AgJKgTv8XpQ3KnhdsW9x068RT6vpN/uFabsrV18N39GHnPKVAZEO+nuWD/dOy1+J4W15281t1NX4JpE9wdzhP2vLfE6V8qdOq18jJXIDcwW2XuM+mwUigcnL6huxUK49ZRYTpu2qtaD9L77yejTGHWNuAWe0yH/yf270Y5t0XsLaIi9TiAL15EsoxNz8TN/UOb5fEkVJCXgl4bLSdjqzm1cgnJNBjV+yiUol0R4gQzv5MO9SpYNOZSZ0S4TuqwybxiC5x7a9+78gxPsljuRKFxo0maTVNR4GSWeNmPHTjWr92hWjl/k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(7406005)(7416002)(36756003)(6486002)(33656002)(6512007)(38100700002)(53546011)(122000001)(6506007)(186003)(2906002)(66446008)(26005)(5660300002)(71200400001)(66476007)(83380400001)(2616005)(38070700005)(8676002)(86362001)(64756008)(66556008)(54906003)(316002)(4326008)(66946007)(6916009)(76116006)(8936002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uUkr+tp1UF1Ml4Fb7o277H9r/A3kdNwE7dXk4tH0tRD22HKX12jku0pdQ2uG?=
 =?us-ascii?Q?6QuLFF5OTCygisXRpR9Z0KfGTubA4mX0P4cKqpjRxGlEURJ45QG0lYuKUQtD?=
 =?us-ascii?Q?4mmH9c9H9r7hIeuLpj5yI8Fqd5DJmwvzSHmRzRGJLxHO+UoDP448OdFtdzNt?=
 =?us-ascii?Q?StGG1Ct7/J+2g2B2e8hGHTMIIH7CgVGGkFjpRkB8iKvgrROD0xVyny9x69TR?=
 =?us-ascii?Q?8IFz0n6Iu4u/7yIro3y4zj2nQTiLlyN5CNSqJQmlAZo61nv/h6bUQouuiXdB?=
 =?us-ascii?Q?JaVGjw6yUqzYVxMNqnu7NZw8imgJfoV0hDtOWq+vauOBN3nYV0Csby4r36Ob?=
 =?us-ascii?Q?NIXA5Xlw03y1mH/i/JD/ltMvnA4XAOw2uzymQ26LOHo5kYp9QLDKTeaPzQLN?=
 =?us-ascii?Q?EzpSIlCwEmJOJdix6XpsvloKi1C9OmI+R0ktVYTMsrwdhhZ+xTyjD1obgf22?=
 =?us-ascii?Q?nXKxHaXSTDUg1z6+rkAhNpBr+SYnGEnyZR4n9Xw22kHpsHWkm5087uu0oMt/?=
 =?us-ascii?Q?gp0OzDdhmIA0SrE0azr48HArbM6LdrNgHc9OX4VkR/RsGsHpPDFo7PgitCJh?=
 =?us-ascii?Q?HPlxrBD0UuHgIhnIJhP4m/liXMKTdEsWPHzx4/LshZ6ehuyWeLxQA1YrSMLe?=
 =?us-ascii?Q?dcsh9Y9R9I/xvRE8HsnfHT4LnSFgzx59Rs3x6fmDbi61fGSPyXSnIEyKpxXi?=
 =?us-ascii?Q?adYRXZlnpyQ6QssqeG0BLupYQS9zb9LDH9cPSViR89lJ8yskm7o0eI7QEz3n?=
 =?us-ascii?Q?Ll9P4e44rX+DdKI7FBGwggFb6MS9ircVKhq5F0K97jiNtrxu5fT3/X+RcNDT?=
 =?us-ascii?Q?QGrWy3M5RNcJSqDOqiR7nTSHM4UrgQYXkyx7l9NfccrGOiYpwcT9Sv29Yx3w?=
 =?us-ascii?Q?ZaGlbAdKU+MYqu8iTB7m5NHIj80rhEQlPJC9WNKJjPAK7JpOZYnc5T2X0iqo?=
 =?us-ascii?Q?sXZOo1fmbwc2S9/OelbIBg3DdtxJKMeYV2LsqM55paCOTY06qe22X2pkIzHa?=
 =?us-ascii?Q?t1J2Tpw37MSZbLR/W0+bf0KhHw2lB5krcGkvEakF2M1X1ngZ+vdNwDoFx13V?=
 =?us-ascii?Q?yjrL6sYst3mS5J0+1YUlerqKqxOJb83C1kC2qSOEeVypZJb3HYb/thLZjJN8?=
 =?us-ascii?Q?YDCnQe41dfBLgFu2urHdaApFt9at8SHxhD5RA0jObS91JggElSzd0afsD810?=
 =?us-ascii?Q?50l7J8WHuZ3BcD45V8UBaXEcI/5YVToLbnI/oDKJkjTG17EZq4BfVEsdO+2g?=
 =?us-ascii?Q?txah4QU0+MSis6LTTuqiSFjEcd3MvL0svjYuoapszeMYbI5qWQ2LXRlOW2X6?=
 =?us-ascii?Q?4tHFOGSMiV6CdLVM9HhhQ1xDjq2qoHhOUJASLQpC0zqGCZ2oMzQK/xjcnIPh?=
 =?us-ascii?Q?NvSx+CT0qpK7ywmweydZsR8XZdlLYfaZl1/4F8kLEEjhfldDSwEfnvVdgvAt?=
 =?us-ascii?Q?DFPuk/uF9Kbp5/qOkR8eapNTu245sN5n7o2CFi74HCYDo45jqzMOQ/r7BPEA?=
 =?us-ascii?Q?3TGM1mqZrfsSFPS/rVGGR+KTW4kVJHPdg1WlyJ7A9XPQuov1yHEWXxvyT0i/?=
 =?us-ascii?Q?sJihZmAXel/Jj7kivJIcO5eK/AZY21K9CJ1Uq8Z8gPl54yjnOG+O/iU5fvDl?=
 =?us-ascii?Q?iRWFlHKhGBUb+4DzHcpNXs4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB8CBBD046C30343883FC8B66FBA3B49@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9517d1e-b9b4-41a3-11cd-08d9c1873927
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 18:01:17.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2feokE6j3vrUkD/rI1ednpjxGke2ycTmsRkI0Ov5/Qxszj8RsSWZXP4d1mDI4DlKsRZiZ5ZSy/n+ty1TaHA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR05MB7143
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Dec 17, 2021, at 9:49 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 17.12.21 18:29, David Hildenbrand wrote:
>> On 17.12.21 18:02, Nadav Amit wrote:
>>>=20
>>>=20
>>>> On Dec 17, 2021, at 3:30 AM, David Hildenbrand <david@redhat.com> wrot=
e:
>>>>=20
>>>> Sometimes it is required to have a seqcount implementation that uses
>>>> a structure with a fixed and minimal size -- just a bare unsigned int =
--
>>>> independent of the kernel configuration. This is especially valuable, =
when
>>>> the raw_ variants of the seqlock function will be used and the additio=
nal
>>>> lockdep part of the seqcount_t structure remains essentially unused.
>>>>=20
>>>> Let's provide a lockdep-free raw_seqcount_t variant that can be used v=
ia
>>>> the raw functions to have a basic seqlock.
>>>>=20
>>>> The target use case is embedding a raw_seqcount_t in the "struct page"=
,
>>>> where we really want a minimal size and cannot tolerate a sudden grow =
of
>>>> the seqcount_t structure resulting in a significant "struct page"
>>>> increase or even a layout change.
>>>>=20
>>>> Provide raw_read_seqcount_retry(), to make it easy to match to
>>>> raw_read_seqcount_begin() in the code.
>>>>=20
>>>> Let's add a short documentation as well.
>>>>=20
>>>> Note: There might be other possible users for raw_seqcount_t where the
>>>>     lockdep part might be completely unused and just wastes memory --
>>>>     essentially any users that only use the raw_ function variants.
>>>>=20
>>>=20
>>> Is it possible to force some policy when raw_seqcount_t is used to
>>> prevent its abuse? For instance not to allow to acquire other (certain?=
)
>>> locks when it is held?
>>>=20
>>=20
>> Good question ... in this series we won't be taking additional locks on
>> the reader or the writer side. Something like lockdep_forbid() /
>> lockdep_allow() to disallow any kind of locking. I haven't heard of
>> anything like that, maybe someone reading along has a clue?
>>=20
>> The writer side might be easy to handle, but some seqcount operations
>> that don't do the full read()->retry() cycle are problematic
>> (->raw_read_seqcount).
>=20
> Sorry, I forgot to mention an important point: the raw_seqcount_t
> doesn't give you any additional "power" to abuse.
>=20
> You can just use the ordinary seqcount_t with the raw_ functions. One
> example is mm->write_protect_seq . So whatever we would want to "invent"
> should also apply to the raw_ functions in general --  which might be
> undesired or impossible (IIRC IRQ context).
>=20

Thanks for the clarification. I was unfamiliar with
raw_read_seqcount_begin() (and friends). Indeed it is very very rarely
used.=
