Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8B4798C8
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 06:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhLRFXa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 00:23:30 -0500
Received: from mail-sn1anam02lp2040.outbound.protection.outlook.com ([104.47.57.40]:9449
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229473AbhLRFXa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 00:23:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyT5A0ircxb+usp5hoi7C1eKnMdgdFZu/SzaufzS+b7tNtA6OWX0MLKFHFAH7V6AsA6S8ZHZOwY/XMTtLhU/7lRfuqfIGWxOUbYLiRhWgon4Azz/B7uFh74ep5gCH7F6N2VB08DB1NbqDgeUsAkwKxBl3MvN2MgckIK4tpJe3kVX/hK+rtGbv4n3dimozB2lGuVZHPLcCiIYYk7+6OCxIb+56C4kGFcXbvEV4MmpYp1b1vnJehh4qKIZnk4Wba/LPBZ/uolWvCA2IWawpDMRQQ0sInQgppML/GyfHYlk4v/OUz4J9gyJnfvnNHadRIj69uZMs5ipBs1ZY94qmfniYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfM8QEeE4+EDCXBwPXNGm7xPDGmiDWC8G529NPMB8Zo=;
 b=H9n5Co+/pOuy2minAZUK4bVVpW/ha0f6W4uIYe2qVcon/BvnVCDdlTxNa196RmFs68dbJ+ekVkoM3Jm21SSt739VoH01zccpuovGVwLR9jWeo6r/RmuHPQtPT84p+l8ZVzYdEPC7HkCteblFhZAHwiyaUUdfi15+Fdaejgm+gPUuG8ExhK0ktUnj9yBA0NlYeVj1uLju26Qd2sRWYQ7U90n0Z25IbQ8WNtxZSc1EORa/8O7ZAgvTqspfasSOTcWCis6tF3ysniIR3sPhuvyz09lc6RUSVhke0Hckbm7Z5Nhwy/Mxe2mc94/8yQP7ZdDy6HOLx3LTKbQs9BSCPSqkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfM8QEeE4+EDCXBwPXNGm7xPDGmiDWC8G529NPMB8Zo=;
 b=Qd+yAv38FWpRCt9HtPoEeAUuFmtRs3CNqSit1nXkDVzV95BUbU+jRKmS5YC+1tMdqYy8c+clNjzeK4ZGrmwDqlJSLYu2hv62GwcQgq/JlyfmnKdSHIWqe7JxGp0SA4+q8tyaUFsg+hyRKonFY/4GizTJZ9Q1EG50hv0jyhpCX8Q=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6630.namprd05.prod.outlook.com (2603:10b6:a03:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8; Sat, 18 Dec
 2021 05:23:28 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Sat, 18 Dec 2021
 05:23:28 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAcDwCAAAMBAYAAC2GAgAAC+gCAAADIAIAACxEAgAAIKACAAAiogIAABosAgABFugCAAA3HAIAAAzCAgAAFi4A=
Date:   Sat, 18 Dec 2021 05:23:28 +0000
Message-ID: <C469C1C9-1362-4DD3-9106-2765D94C6350@vmware.com>
References: <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
 <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com>
 <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
 <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com>
 <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
 <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
 <D54E059F-9757-46DB-919C-A31A067276CB@vmware.com>
 <Yb1rqe7u0YRxqzgh@casper.infradead.org>
In-Reply-To: <Yb1rqe7u0YRxqzgh@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1078e237-dfd1-42cc-96b7-08d9c1e685e5
x-ms-traffictypediagnostic: BYAPR05MB6630:EE_
x-microsoft-antispam-prvs: <BYAPR05MB66304858585DEA5D3EC41C98D0799@BYAPR05MB6630.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1luFPHzWmOG04cV7dF9S9G7oL81Db9ps2gfNI+cW2QUH4gzT7Ay+OM7aihdWVEyxMyuRm8neaRnNyE9RXKzzWxRK3ThbIQ1Lom3kvJhc+jXXjBTKraT65MOLnFYMCYhHGZklFiaS2vD/ZfndvgNDfOMyBDtEsyaS0m6NSyQO9MGJd6+aomgEpVaZ+M4a5+gpoPMuDopP4EQGC+EPXNctprC63SVBh/t1xXaQzbw8/LWo+0sMqGPcU/8Qe6MT8YhpbkQHJRA6L4ORw7C5s9ijv482VwhtHTasOFxig8klAwK+l9g3RWsx2xjI1EJl3b1+Gq02AcHoMYmUG8KwJcJJFE0+zIUqhzznOaNumSYBf0a5mvAloj8Eyq2zq1o5L6Kxl9SokPjPrCCx21F9RGrzGDc27783a7s5tZ3T7yeLDyWWzPq7XQ5GvPc9En3WNbhFPLKU2+DpRMLDQI2qRg6snkNhqA9uu+iRIVlxAK8rjgmYYGmRRk9nHagJzGHcfLBcGRvcRz17AAUvOgyKJB+mVj+o7xDE8MdBi+L5Xf4X3QaICfKGJLQQxB1HMWj9Rjk11IfqOcT6lNiOhXmkpinUMJmC8zuKIj1UqZ3f3fwNkydQJanLH7d++5q2kh2HNwWpjyKvoSpqGsQ/kvZGBaS2bwSZbnyDtGxn1jX7yk30qdIZryrh0TDoChwHdU+wMphi3Gnc6+H+WzNK9/Bz87M1/7tB7SCLMwhkC/pIjL6vIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(5660300002)(76116006)(6486002)(6916009)(66946007)(186003)(8936002)(54906003)(86362001)(316002)(64756008)(66556008)(66446008)(66476007)(6512007)(8676002)(2616005)(38100700002)(26005)(4326008)(38070700005)(53546011)(6506007)(71200400001)(36756003)(508600001)(83380400001)(2906002)(33656002)(122000001)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+VKEJvqp8AFqt1feT1qjF92PoUMPIzQvDXD2E/+C1RrSUWp6vhAPFoHbI1Ou?=
 =?us-ascii?Q?4TVDEFVmwwP53gyAgnDZ2v2q9AfkmGMITIi1jvYIiD6w1v6LHh7jUkDoPaIs?=
 =?us-ascii?Q?8g0ALdUTkRaf9Mt0vNCZ6p3kZ4XIXYWqIuNGenCAKcjxs5oqZeifMYbYwVIy?=
 =?us-ascii?Q?sE2/VruhNjVUecfp4GQImxtX9Ps6ITdMtb8/uttb0hQMIAA/e/bIsh0yCw9V?=
 =?us-ascii?Q?uyVQV8bURqyUz34xDDQuUurNH/n2isXd8YuUpyvhH5We7Zcc+9sfOrlqlkY5?=
 =?us-ascii?Q?eR6dvzkpxJ5/eczcOGvgB9o5a23VdYLCPpJ4tF3TJ0iULYoV4RhlB3W0D1pE?=
 =?us-ascii?Q?PAj7cTts5xsafYepvi3Xi16J6J9McAcx9rvtTrRf4j5RAQWmon7kfENHw7z5?=
 =?us-ascii?Q?zYlrojQFzfKI2AjIon+aol7k/tcvOQ5xXW8dGYK54ndYdnIMcIAorSjFyVba?=
 =?us-ascii?Q?FUis6rIJ8W1goDmQwUhNr4O7DuwbebbSvzIQxnLn9RQ03xX5jhxHokZy0g+Z?=
 =?us-ascii?Q?QgLb4zd9vRiQIKP3t0T+iG5K1L/8eFWUA4KWDV+f2DweNazqeUcRrttQF/yw?=
 =?us-ascii?Q?8yCb9Ia4OF18TE5JYlDMdUgCgPCF2cTOKFapYIBgYvI1Fpk9XE9XfEIINgJ/?=
 =?us-ascii?Q?v6wae4aLHU2fRTeTQ7GLfIyBx/klxBRqDd8aVYeaiP0tWP4GHOzyI4EnyOzA?=
 =?us-ascii?Q?Qf+7dQP/IVr3ifSAq81HWgG1dq762wGZbiIS88TYVFEfyMHheOUlqgpGpjix?=
 =?us-ascii?Q?eDrpVHgQo2ldGp7M6UhmBd3iOb+oR4xEXaqaPwXhl+y6LyLqNggcVoFEoNcG?=
 =?us-ascii?Q?k6yx09M1MK79Ye3QfnVTKjMsUthwVrarR4oGBC2XChGJwOrQX+lXocpjYfMw?=
 =?us-ascii?Q?1TeGr9rG1XSR+Bk4LrB908IA2hlD0NDPrikYPX8TVpPVCAP2/H25Dx99esnX?=
 =?us-ascii?Q?BHP5khNrwH8vsiL8N+fweKj7K+2j8JLqjSYiZL3XZtLHUIOPHVZ7YPgHgL6M?=
 =?us-ascii?Q?u7in/d25pLAQep4rVKJBqFmEjzXu71/yUeSzixWWSX4rNk8c+ix9ijLVynNZ?=
 =?us-ascii?Q?5nQDPKLnYck3GuJ+RlY9y9MI+qh65MOD0bQSnA8+ryHDLmqDQ+24g0P8fmpo?=
 =?us-ascii?Q?pJUWpW3Ts68Yb80kn0UgWDaRRuuDX39WaCfOzjd+BbYAgqLhcM4zV/TGqvDx?=
 =?us-ascii?Q?A38JKXwMMh6r3N5PouYkfdyMOIaBpNh7HfKWEdT021LubyCLNM7qez4RDNbO?=
 =?us-ascii?Q?dszJRyuFUF6BmLLYiEr0duGlbHjv7g9P5KJsfXgzdCaoDqGW0Gb9cWfNloDu?=
 =?us-ascii?Q?o7bUNhw5W9+VEtwznpGvOD+wxTgQpbViIsShMB2D5Qjw0D4WJacecFgkq4Ry?=
 =?us-ascii?Q?QBuTm5BVHsaOJUc1Q4/en8q2tsXMMhEJbakmmu6a+ZCfzGH2iAWCxDLwjHRz?=
 =?us-ascii?Q?1oXFUuiO0jIdkFtd9qcT6zGUXT4ybCoaqkTXMfzwr5NdsHID8MJH0OyzGJoC?=
 =?us-ascii?Q?bzlGH2WKnzCv1J7aa6mBNlKnpid/BiLNN+ZXZRWQYK73D3+72MA8f5QeOBXM?=
 =?us-ascii?Q?zEXehdfj3hisHFBFw8xaKk4L2xwxzQfYUlyuaJVUrGgrziFhav6gz0mOAyQN?=
 =?us-ascii?Q?Ri2ikIq/Z+8bQLY9bjO1xHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <512B91965FD7C749B7AF6F4F5D24BA42@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078e237-dfd1-42cc-96b7-08d9c1e685e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 05:23:28.1597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8zyPQi9eg9NgPkCCN5tqZ8XR2insZRMP5DWeyK0rWDLdDrE9TywGvV1QjH7m2APJyPX+GkX/PlqyKpytJRV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6630
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Dec 17, 2021, at 9:03 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Sat, Dec 18, 2021 at 04:52:13AM +0000, Nadav Amit wrote:
>> Take for instance memcached and assume you overcommit memory with a very=
 fast
>> swap (e.g., pmem, zram, perhaps even slower). Now, it turns out memcache=
d
>> often accesses a page first for read and shortly after for write. I
>> encountered, in a similar scenario, that the page reference that
>> lru_cache_add() takes during the first faultin event (for read), causes =
a COW
>> on a write page-fault that happens shortly after [1]. So on memcached I
>> assume this would also trigger frequent unnecessary COWs.
>=20
> Why are we comparing page_count() against 1 and not 1 + PageLRU(page)?
> Having a reference from the LRU should be expected.  Is it because of
> some race that we'd need to take the page lock to protect against?
>=20

IIUC, the reference that is taken on the page is taken before SetPageLRU()
is called and the reference is later dropped:

lru_add_drain()
 lru_add_drain_cpu()
  __pagevec_lru_add()
   __pagevec_lru_add_fn()
    __pagevec_lru_add_fn()
     SetPageLRU()		<- sets the LRU
  release_pages()		<- drops the reference

It is one scenario I encountered. There might be others that take transient
references on pages that cause unnecessary COWs. I think David and Andrea
had few in mind. To trigger a COW bug I once used mlock()/munlock() that
take such transient reference. But who knows how many other cases exist
(KSM? vmscan?)

