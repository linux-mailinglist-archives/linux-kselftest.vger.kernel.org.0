Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013F479612
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 22:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhLQVPs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 16:15:48 -0500
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com ([104.47.70.101]:32459
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236219AbhLQVPr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 16:15:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV2AGdSwk4wQggBfoY2FgCS/TR1QZd9+pJgOWUSK2/c6PakpjldM5TIWYQ3VYCUJKjAmrkRl2maSRQD8QcwzA53pKdUJWc9e6KjEjWbL8tDUAgJXnF2USMB+WurIE3HkpCLt8TwIkIxCVOUwCNtiHO+Qkqx7sexSySFVDnzUNRG1nWK3/A9IUivuVdPi+dgJ0nreELCg35bEK23a5S/GZuYZm0pGs38Xleo0/vaGdXWR/18Mc0F3xLqQdy4fa6m5QGPM7PflbFuwfIae6WNb1/EMtqDMrn/5v5dc6HsPwOBF8fziGEZQnb1aOQRJLBfjav33HegiG0FLBMPbdgtLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty1FL804QXcF9TrAE9PgMoEr0+PN7YeBsLeLSppD3YE=;
 b=jnMJUtG9Y2+D27KMh4Tyrz6MJ/WhMu8ZYAefzl8b62R2MZc8mzfMn4iIcivv2Lc/4uUyQ2DIuK0L+B1bGvZFOMvIpLa2eZmYfFYfZ7aXSILE4+1+45Cor1GVnyexiixP+Ma2zWm7OOcYJ0Ngj6MiY6yivPC5mhgMZDDEjyNLzNhHHTKL8ToIQ3ll5ASI41BP15EB/KmjWpo7urWn0Qrcn4QQqfoxCOiV1S9lEquLjKZ42fz7/z9L9WSgD68lilcskhu58Jvq40B+hzYvCgXUxZdvop4pwGba5mv2F+9LCSb8OIGIWWJesW5Hg45LLj3R/SAoDcPjnnxUD0XTqFwWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty1FL804QXcF9TrAE9PgMoEr0+PN7YeBsLeLSppD3YE=;
 b=eOko4Lm3cAE4ssHw1LhR/84uUSPKdpnoq2lLe40I3XrssABhJ6l3Emz9/95W4mvB3EEjFpYmtd6p2sZKbt1B0uuifHkbcNUXdel0bZ3ZYii7qogNaGBDNw3ccgarFNEkRSbMpBk7bdyr4IXFExVFxYBnTWtWFuh+s6HChx6Qr4M=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MW4PR05MB8251.namprd05.prod.outlook.com (2603:10b6:303:12c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.7; Fri, 17 Dec
 2021 21:15:45 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Fri, 17 Dec 2021
 21:15:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Thread-Topic: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAFCICAAA9rAIAABT2AgAAC5YCAAAgCAA==
Date:   Fri, 17 Dec 2021 21:15:45 +0000
Message-ID: <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
In-Reply-To: <20211217204705.GF6385@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 837d97b3-028b-488a-4b4a-08d9c1a263de
x-ms-traffictypediagnostic: MW4PR05MB8251:EE_
x-microsoft-antispam-prvs: <MW4PR05MB8251BBADD818CED5EDD33192D0789@MW4PR05MB8251.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CnjjvmIYRe7DxneMSaKrV4U3YzUgUbtsYW2IWS0oBxNRj7LHSdcfj7d2ZjspnQm2+IpFjRpd5mMWZghwXKcmtell9LUWpbfUzFG5xSVN0JxpoUukeHWQ8osTMkdKwz4AyAY9oPs59M7AqU2B8LuS25+k8dp2BNGXnmMs1eJjkVgjr74aFUJppoYLAScL20shhwN60YWbfRsshLhIEyxHHGpBTueFj35BrgBapELCqBFFtDahjeR6Rx6pbLE/Mytmvwly3T7WLuwOLp2jwZSfjRhmzLSm5x7LGAuA4SUfhZBSPv9AD+swR8GsA6vYGp+fOUoXUXUtl3fjecF+QGJoxvjjRFcbuwpKqahpHxNxW+lIQcXV1gx4A1c9kAVn2WUNhVmXAMQwXktO1QFav6NU36SpslehMXby9O7VpKuxbQSHdtLdEjKGsXbXMFlH8UOrUXmMVX0D3vyeiJhcbO5/9wLlHN0hWF7ijByEu3WFGC+hxM0vfdSXcFAGXFUiy7uPqU1eitmrUEONgmO6DsEhnQZSYNX7cSCPh30RKwdssAZhvqypsyTuhh7xROX/ehnL/733d2Ma1ET6IIWW+Rvghj6UhyfdL2eZPGAF3Rsp/Kqp9X/CHRqYecwRMBwJYT6tVsVQMIS+lnWo/+quogGaq7XFhpQZ23hEEHzUD+LbSry6zgGMkPU1S5AGxl80I5R7/2Ha2UiCg7Mn+UkAqac05TaX4Xuu2xCyjkg81efX/yWif+piN0feJQWvBOC9uJhH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(122000001)(53546011)(83380400001)(7416002)(2906002)(36756003)(66556008)(66476007)(64756008)(5660300002)(4326008)(33656002)(8936002)(66446008)(8676002)(26005)(316002)(508600001)(54906003)(186003)(6512007)(66946007)(6916009)(2616005)(86362001)(6506007)(71200400001)(6486002)(76116006)(38100700002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lklrMpDnfOhCLY5QRcREGfsQrFtxW62zZj6Go/Brci+NEeAh4W2ovvH4Nk4Z?=
 =?us-ascii?Q?593ipD8Es+B/XDiLwMKjGa8pJyj+C6sMcLhQ9EoqxMf58UWHv03te0VPFT6W?=
 =?us-ascii?Q?4uVdbTOec4JHV7J/MxufqEhh4FKpHKQJHdDcFGpgs4MCeNh1FvsB4XliRY3+?=
 =?us-ascii?Q?YYJQ7k+clQmzAcwH/B05Gz4Q5Mym3pGSPCa0OO4YoBJkRnXx/16R7h7yJjVC?=
 =?us-ascii?Q?ujgWm4S7HRfxoSyOXYwVybCF8jlJaKgLURjtfUtSKa5RneudhtEstoX6o6Le?=
 =?us-ascii?Q?xRjr6RPLe1roxjZh3UxXXnHnY+jfKp1DethB06XFb7dHv80nPY3aOmh0vn0s?=
 =?us-ascii?Q?gP2otaqUWLAA0h8DLzgq5K3UXUKOybVW+7WtOus60mUV68rpqLBRCCn7eHOC?=
 =?us-ascii?Q?ehakzB7aItFSISNmvjHhfRB4S39Xf0l1tEpAhLe5EVJbiOgh8W6ATk0wf84Q?=
 =?us-ascii?Q?p+ja/aYAjolNoIaUqko4GKBh6ATB+dO1enNQ1z9WCTaexqna/O6W1XW8IZfl?=
 =?us-ascii?Q?4vgItALJPdUXUPzzL85XVVymYtlv2wbfYKhwlqhymHzx6F/lKPlRO5nUV3eO?=
 =?us-ascii?Q?DKrbWxsYTIx8tYiLAJts/dthhMA1QR6WxzalxW3OiiiaBKaFj1FZ5feWR3b9?=
 =?us-ascii?Q?yP9d61a7R7Mr0trpFmp6n0vylIauEkqCUNN1Y8mUF3TAPmoQPhtIZP2pgUgP?=
 =?us-ascii?Q?3+YfjJDjWU7PaK0Y+JXLeiMQakQ7JOvVcEDBZyWi0oJXrUo3PmV764wULysC?=
 =?us-ascii?Q?TX8cNiCkfLT5H/Irx7GKRivHsRR/6EIqNs/2+ld9CZ3O/viBHGe7bRBbrS3S?=
 =?us-ascii?Q?GK1qnCkbhkRSP67tZhNFqSe6pRQcXE3c201irmcGrMLqRom6IJSFqILmb1oV?=
 =?us-ascii?Q?IEL80GvIfeyOY8azehZcHrEo66egRaouOYc1k+6o1/PESgtIJtUl5Ceg6cSO?=
 =?us-ascii?Q?lsHnL/wsUT2iaINaYNqROn4vur+eCdMdNP1xtKiC4/qDcoTeMg+dlfBOiPoZ?=
 =?us-ascii?Q?gAd4or7r/s8pbJC1T9pkPn88lYlCZ57MBYT2K35BSnkINIFdxpYjRQJd55WW?=
 =?us-ascii?Q?lL5sfg/rQHK1icY4cf7nbD/Duo9f8vPbBjqNmC/p07iUoAYDkFChHrON0/pK?=
 =?us-ascii?Q?40x1/uISGowojZsj2swKDgxK2B/U5pTQ42FUCokA4/d5sBB7ve9mOHmPyFT5?=
 =?us-ascii?Q?HTCOaek5zSHTRC1pendb0VUDsWEmxtciaBLtYkMl/NeRpPkLjXmoI5UGeQMh?=
 =?us-ascii?Q?p873PXr+yGN7XTP5PaiuiN5v5wqPtBz+2SQV1ldZzspL2e/63hBKoza6i+27?=
 =?us-ascii?Q?3+m7Ga1vYEwHhtpFF8Z6vdYBjbtewOAq6ude54mCQzPTaw1dQViAcCmGR2FU?=
 =?us-ascii?Q?bVWe71zuGHPAltPbcfRCYieYvfWHs/JLYDJzZfuXpGoL/7M4UZQonFbasAay?=
 =?us-ascii?Q?FuOpGT2eBgLWJ/O8DxRL5+o4Fzud5i5jurxzixR1HwQp8NpByfYRwWNFk/Nc?=
 =?us-ascii?Q?S0z7Re9lXMdCUcyLfLPWQbBNfTtriNiEnov5RUsuv8EbFEo9UUUyI+qlNiR7?=
 =?us-ascii?Q?+5sdv/r2C1/ZBHFRmKh8fKiVxrmPd0NglJeRCgCOnFU+r9+Jt7HJXJJNjkGD?=
 =?us-ascii?Q?N+X7Iec5eigDP9dIGjRowIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9496E3542EB7704FBE4F447ADBB95910@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837d97b3-028b-488a-4b4a-08d9c1a263de
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 21:15:45.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GT/RI1vr173X/sv7HfLcmo5xD4BoCGxizhi8j32T0+1iyyrFeGtdwlD8bQi4h436eU1uEV2TqfKFUGgA1gVU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8251
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Dec 17, 2021, at 12:47 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Fri, Dec 17, 2021 at 12:36:43PM -0800, Linus Torvalds wrote:
>=20
>>> 5. Take a R/O pin (RDMA, VFIO, ...)
>>> -> refcount > 1
>>>=20
>>> 6. memset(mem, 0xff, pagesize);
>>> -> Write fault -> COW
>>=20
>> I do not believe this is actually a bug.
>>=20
>> You asked for a R/O pin, and you got one.
>>=20
>> Then somebody else modified that page, and you got exactly what you
>> asked for - a COW event. The original R/O pin has the original page
>> that it asked for, and can read it just fine.
>=20
> To remind all, the GUP users, like RDMA, VFIO use
> FOLL_FORCE|FOLL_WRITE to get a 'r/o pin' specifically because of the
> COW breaking the coherence. In these case 'r/o pin' does not mean
> "snapshot the data", but its only a promise not to write to the pages
> and still desires coherence with the memory map.
>=20
> Eg in RDMA we know of apps asking for a R/O pin of something in .bss
> then filling that something with data finally doing the actual
> DMA. Breaking COW after pin breaks those apps.
>=20
> The above #5 can occur for O_DIRECT read and in that case the
> 'snapshot the data' is perfectly fine as racing the COW with the
> O_DIRECT read just resolves the race toward the read() direction.
>=20
> IIRC there is some other scenario that motivated this patch?

I think that there is an assumption that once a page is COW-broken,
it would never have another write-fault that might lead to COW
breaking later.

AFAIK at least after userfaultfd-WP followed by
userfaultfd-write-unprotect a page might be write-protected and
go through do_wp_page() a second time to be COW-broken again. In
such case, I think the FOLL_FORCE|FOLL_WRITE would not help.

I suspect (not sure) that this might even happen with mprotect()
since I do not see all code-paths preserving whether the page
was writable.

