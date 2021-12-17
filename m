Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651E47924B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 18:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhLQRCa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 12:02:30 -0500
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com ([104.47.57.168]:33847
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229474AbhLQRCZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 12:02:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvYZMD+RttNY2LmXXMd0QY7AoYLTPQ2e6UqIsdesa373IAIBSJDKjkIzSGjqokjel2ZGCWpS6hyNsGlTUj3e9DQwyFNy2lYjriEOUNfja5PJT3VBNHJ1l1RGMmgwvVNCHLFSE+CS3x65gogTDkQTiq/awmDnkvqrFML+erHooyYVqGwJvs9W93LWBSYcZtbKb0UL4EEjF9XtfgTz0ya7awUUjovNXRiVXzv9O1iHhrziOKSP2IwDDOwF5pc2ZR8SCWk7WYbNakY7VmEoAaT+W3WOratj48XxhtwCNeHU+nsUNB7kIaLFnOpgEvHtXHGq0jV2OLxinqDH7AbWGRlquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KYr9yyqmT9WH4BbHpommzdvYScqfie8tP/yK/nI8IY=;
 b=b7f4GwXrg1+jzohUhujRvQzOiiuD6LTzcVNYvj6Twm2OC2vL/BJTuUWgos3250kk5jIt6viuOYOSmhR6on9KCCRgxc/xU4ECOcJa+KA4f3UetkiGZI85JqTd0lSHdhRmNm97HmEKA3OC3jk4j5BMHZwax0wm4Ddq+75NdQ3Xv4Fxxsiq4dSWGPPXtLSHYJ3FKL3g9n8DhdbvYpagz76/uk+CntanLZ7Cde7iYnJ1B0qXxDR5oTnd7KuWPEHYAbjB+htWKWSxj3HinhZoRO0rou/zE5UQNYCb1BPBjdSqtUynAPrJbcdg4Riok7a0ulsH3Hhx+17A+9uvQW0ysqNmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KYr9yyqmT9WH4BbHpommzdvYScqfie8tP/yK/nI8IY=;
 b=Pos1IVaKQtETesLg74mllNJ0dgac7VlO7a+vTPJX3urgetgjKjZ6N6VsowpMqAKneQC7RL/FFdmy3u4SznT22kws2/jqDItL9pfybin1GshwJ8ogWgp29smJyu7Z+N2Dx727JYgLB2VQviXXBSH26/+5panlDxIZW1JTkd0zTcU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB5608.namprd05.prod.outlook.com (2603:10b6:a03:75::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8; Fri, 17 Dec
 2021 17:02:23 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Fri, 17 Dec 2021
 17:02:23 +0000
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
Thread-Index: AQHX8znaqyMNBisG2UGD/gNtIc+9Gqw26UMA
Date:   Fri, 17 Dec 2021 17:02:22 +0000
Message-ID: <38BCB153-7E7C-4AAD-8657-E5C6F9E1EF9B@vmware.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-2-david@redhat.com>
In-Reply-To: <20211217113049.23850-2-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f21ca664-67bb-4c3f-47ce-08d9c17efe97
x-ms-traffictypediagnostic: BYAPR05MB5608:EE_
x-microsoft-antispam-prvs: <BYAPR05MB5608F555ED928469BF65CB4DD0789@BYAPR05MB5608.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vlsNYwhGAUhjlH96yyHBjiuu9BhA9E0Om+8S0y8uq0kTvY7N60FU0Z/cnwBGDPxC+fxIHncivxKiWGFigrpox+o3juo/rUkwT01gonsrHm1a1VMtZ8D5MF4RlN56r+uR848QSd1Dt1aChHPaHhAUoJOaVQeNsFIST1VsF54lTXZ82k/rvQBowUzROySsgnt6Kq+lnqvd4OWRadLipb2ExKK5tVmtmIeAx2XyjsUCBxQGc59K2Z1t0lGZK/L6r4GtPZBWfKD+HAnfUy3Kg56DRDiTBu/6161GdkWwzfglfFLjx0GyKUZWfSk9+gFbQfTfipV6ao5EOt1lli99rTigh2jgCII2R/GL3Q8bb+So4DoE8+gmlQuiywQQ8RHDsPLGKtwCh5s//IWFF+7+elC92O9OYwDRo3uhU9UEWrbMuMwHcDmMGVJueS6YqoGR2MNTOeq6mHPCbUbnwARNlk4L6Fpfwvz48kD+g8S8Ii8m3c7egUF4nMyLF/7jophnA6yPpT6rSBdv4u1THZFgYiiswOUUCqkEV7Af0+v/toPzTnmljj/p6Fr5lKVazGIAY8c2jSucHGXNkwpGl+bNkaHxg3emEoOgyjWx5vRnDQ4c6Biq7ZuOpV4m9vIY/w7ucbtxylcrpfHbmgaSDQxRFJ2udqYsmd6qrPIObx5Uva3R97wHIcHIvEaBnxv3KwVAxhWsQn2Yg5tFQuTBBgGjO8e/D2Af8vwEhIKKpnieSmVmVVg9QuTHgD+TseHKcc6hxXeJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(64756008)(66476007)(38070700005)(86362001)(36756003)(66556008)(66446008)(71200400001)(8676002)(316002)(66946007)(83380400001)(33656002)(38100700002)(4326008)(508600001)(122000001)(54906003)(76116006)(53546011)(6512007)(2616005)(6506007)(6486002)(26005)(186003)(7416002)(5660300002)(7406005)(8936002)(6916009)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y7R1t6vXtXQ/0nrGhpGzhNuAwjxfeHccGQB0wxyxSho/NZPFQoNzshGrQ3aa?=
 =?us-ascii?Q?8oN/ayPurslA952LG4gpmCnUIwy59mU1mw2Fa2glQtLAqUZp2usnvMNuZ9xp?=
 =?us-ascii?Q?Og4T1Wn31qaIweTCSNDjydjSjT3CVNzQ6jHN4gpq/X3lfmxNVhWNn4EXEVQV?=
 =?us-ascii?Q?F2YOnCcmpZSoiXMOJCzslRSTRYe9PwIsQKGXZ2kvvJm0zc56hdfqkAvWIJH5?=
 =?us-ascii?Q?uVCzEu3rwnqAGQRgpWwiXv2jugEVsVp4yt5MY+EXpR6vp2itYQTHpqWDwji0?=
 =?us-ascii?Q?+ZIIZEcQfGyDgUC/Jtp9k+SpudGUSuCT+FBsgBBnAIAk6Qahw7qdeujQz1Jy?=
 =?us-ascii?Q?VHwVBXTUikWPYSZfwZsWHNbd5vj87AbMfmkvwDutiNirq5sUvzDDfsunw+EO?=
 =?us-ascii?Q?wMymiSqCJYJWHwCThDJA3qzwXs/FlhihfAmm+AG7N5x59xy+9ny0PFaWbvab?=
 =?us-ascii?Q?Cq1huVfk1tT6zohXycwCxuDWW1LnM6D1lQy0HTnUFDij5/WlavpD1e4kLTeq?=
 =?us-ascii?Q?Wo51xBE6bTNxh1SshoI9x9KNRobZDm0p5h2RtLIoWptMFV4araxpi4uqyap0?=
 =?us-ascii?Q?vucxslUUpGhj4Jje186BMAeOeAFv0RrLFZu+tUNvMHz4+2bIA5C/5OtPb05w?=
 =?us-ascii?Q?G28mFd7XRiIEuC+CIr2JE9/bw/VIgwrl/gzSH+g2HXY/4C0YR7h+1knnfym2?=
 =?us-ascii?Q?LL6vQZr9Kr/Iqh10xGOOqsoGGMhAvZsmC+iwUxhlfxTO/QkGir3CdEtp1J7V?=
 =?us-ascii?Q?fJ3h69QHyYkYO5Jt2MjhOdGatxjr3XD9KxPTpxbY/h4WgAclPAkSeedqLVRN?=
 =?us-ascii?Q?93Jn1gH3o5S5lpvHUM2azPdnfHJxRqzFOELM1d1Uaj4F8Km/tReOhpiEkbJF?=
 =?us-ascii?Q?Ddlx8sUVEY74zFUQUtQaWt3RNwPJHHcrh7JmF96/44e+TkrV6OF94djPC0mL?=
 =?us-ascii?Q?bMl1oZiaOM2jSh0EXrp5t7sITEr4VoAuUawAAUU5owTbc1OLU0K9a+So5QTn?=
 =?us-ascii?Q?dcVhrtFIa6c7Mtf1CYKeDKA1qJDlll3zFc389ErMPkeHhYx1Ju6Unr5mmpnJ?=
 =?us-ascii?Q?lsd5VL0W61k/xAsxmFF6cjeN1t/hd0WsTQ4gO2rTOsbP9/x3wzz9YK7cPKyq?=
 =?us-ascii?Q?yR71rOq9Mmm15iG9ge35kgOTfh7Mk0AHe+M0jlWHa1ljdiraMfgrXFoqmEMF?=
 =?us-ascii?Q?pzJFu39L7t2b4amJaCINwQ/DdKKBvE3G6mvOUvjCxiUaAObJi2+1vEpZfYt4?=
 =?us-ascii?Q?ptnlOcPLyTBNE2CPp5vw8o2dVVITe6hzyWXToDX4SkXoLLjkaFLAcqVplkg6?=
 =?us-ascii?Q?/3O+CsyYb0B364K+fyn29vfikIQtM+UbVYL0wBQdUwSnoXGIIViwCFs7VzuR?=
 =?us-ascii?Q?gHdrli0Cnj5Syy2N1S5OSjXbIsxYW5XQmB9JLwDTwT6KGBo/LVKxL13JbNfg?=
 =?us-ascii?Q?zP++7AEJauokt3FbW9qLHwsV5qFEOvcvmyQ4fO0rZCeoVBEV4tlNO3e17D84?=
 =?us-ascii?Q?z1ryiXhBRdARgcYnK5fZWO8ZsiifvH5AYf6zO7N+Ogpy6UZpPJQvFaqyY3o2?=
 =?us-ascii?Q?lTbkaZSKHnvwFGnFl0Zxt7VbyVZgv8mYkFPZ+RDTMDSfOV6bzAmHexq/GhWG?=
 =?us-ascii?Q?cMKcZcpzU2ld1oM/o87mjkU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8D0078498047040838514DD039A94A5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ca664-67bb-4c3f-47ce-08d9c17efe97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 17:02:22.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDfWsOHcGTZUovcA8EBxUIoeaPhj+KlS2MqvaYUcClGHiizAuiYLMpiA9wbnjx1vmGKUpbMwkAD4FrxRT7bVNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5608
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Dec 17, 2021, at 3:30 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> Sometimes it is required to have a seqcount implementation that uses
> a structure with a fixed and minimal size -- just a bare unsigned int --
> independent of the kernel configuration. This is especially valuable, whe=
n
> the raw_ variants of the seqlock function will be used and the additional
> lockdep part of the seqcount_t structure remains essentially unused.
>=20
> Let's provide a lockdep-free raw_seqcount_t variant that can be used via
> the raw functions to have a basic seqlock.
>=20
> The target use case is embedding a raw_seqcount_t in the "struct page",
> where we really want a minimal size and cannot tolerate a sudden grow of
> the seqcount_t structure resulting in a significant "struct page"
> increase or even a layout change.
>=20
> Provide raw_read_seqcount_retry(), to make it easy to match to
> raw_read_seqcount_begin() in the code.
>=20
> Let's add a short documentation as well.
>=20
> Note: There might be other possible users for raw_seqcount_t where the
>      lockdep part might be completely unused and just wastes memory --
>      essentially any users that only use the raw_ function variants.
>=20

Is it possible to force some policy when raw_seqcount_t is used to
prevent its abuse? For instance not to allow to acquire other (certain?)
locks when it is held?

[ snip ]

> +/**
> + * raw_seqcount_init() - runtime initializer for raw_seqcount_t
> + * @s: Pointer to the raw_seqcount_t instance
> + */
> +# define raw_seqcount_init(s) __raw_seqcount_init(s)
> +
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
>=20
> # define SEQCOUNT_DEP_MAP_INIT(lockname)				\
> @@ -111,11 +129,16 @@ static inline void seqcount_lockdep_reader_access(c=
onst seqcount_t *s)
> # define seqcount_lockdep_reader_access(x)
> #endif
>=20
> +/**
> + * RAW_SEQCNT_ZERO() - static initializer for raw_seqcount_t
> + */
> +#define RAW_SEQCNT_ZERO() 0

I am not sure why RAW_SWQCNT_ZERO() should be a function-like macro.

Moreover, the documentation showed:

+	/* static */
+	static raw_seqcount_t foo_seqcount =3D RAW_SEQCNT_ZERO(foo_seqcount);
+

But RAW_SEQCNT_ZERO does not have an argument?

