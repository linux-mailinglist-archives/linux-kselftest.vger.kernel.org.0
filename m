Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFB4797AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 00:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhLQXxY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 18:53:24 -0500
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com ([104.47.51.42]:7765
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231418AbhLQXxX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 18:53:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHeOJLiqEeADbSlI9SddsCZdygZAS5Q5CcHxzklLzcz18l1cCSc2tcZKI1f3UnOLTyAjhNzbcQoGjt7Iew34jSGsSpz5+kWgwqliS3Fx4K0kOAROEGngUtnfz32ISY8zWzVnQnbvDOi8uG0Yt81uxGt/YG47xn4aHvwXzvomCTZat3XWMsqRcXqaXzeUdv9LjFF/4897XrIgLJ+Rwp0e1WsOkdBQ+hjnyylvUqZFAhsNVFOj0kUrtgRt9z3s95j3GalBBflcb8wczpej3ispS9fU/Qslv6beX06ega1XKu+GN4GILav2JyBTtZHb7FfNdS0Bs6YjnikKUyz2qozMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eWHh9UZNS9tYsO+hdtWNS1YvRgelASJwpCsr1mx9HE=;
 b=PUxhbqLbvUZnafAcahKwXgSIi5RySqAhy8iaM6v6W2SDbL8e5JyGl5InUIbKevD/FuKgSIWaX5UttgnM4lhR300CqzLxVlbkTtiuEBmYntqKghtAkbFTouGYz34s0vhDeVv+gPQPpD/KtGqhubpyMRm8Re8z4GLbaXt3l1nVM/AYdha2BjjhDfUneoqJ2RgyRI6yp5nfGPnhPo35oWyLRhHsuEgenlmtBQqG6/U5Ubje0YTUIbLEDO+CASkqfFrVkuGSRe1vvodyhHKVMHs7u1BgAZr4/Z33zlpY7rIF85HEltK2nqXbzMHafemrd2+Hv+eUF4BHGr258L3G8QsNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eWHh9UZNS9tYsO+hdtWNS1YvRgelASJwpCsr1mx9HE=;
 b=c+EpSlO83fYK9eZhjvP0Sl0Xi8aiw0975iKx8bEM6/3IPA/FF9nVtY061w1fnyJAVBoWeTxazClIHW73WZszdHBSOp8mQSdmnPqprt42aHBFXazEPypye0As9PN4nD8QeHRzJdGQ1Gy0XxY8V1OU4Sj+zJj7jw9d6RDjdfGFOss=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM5PR05MB2985.namprd05.prod.outlook.com (2603:10b6:3:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.9; Fri, 17 Dec
 2021 23:53:21 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Fri, 17 Dec 2021
 23:53:21 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAcDwCAAAMBAYAAC2GAgAAC+gCAAADIAIAACxEAgAAIKACAAAiogIAABosA
Date:   Fri, 17 Dec 2021 23:53:20 +0000
Message-ID: <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
 <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com>
 <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com>
 <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
 <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com>
In-Reply-To: <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a79ad70-1e79-4ef7-fb8f-08d9c1b867dc
x-ms-traffictypediagnostic: DM5PR05MB2985:EE_
x-microsoft-antispam-prvs: <DM5PR05MB2985280EBF59363DCE00314BD0789@DM5PR05MB2985.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QcLf1gDWNA1DLPmbgGWgbfECJUG4ITmPVvqP+RivfovXyC4GY9cwyOKnMGvzHxDgtBQuRUUr2ZrlZ3YY3xP3RXlrxpj9etwHIYgvnz4+gnujx/rTyLnLwKSez3Tvw8JR/syH68Q/5K+wjPJkjFRHVCBI++ycwHEdw7rgi1AIVwFtD8/OUfyrPi6GSZP33BW/xG8isfSff+YUd2RTfT+lGGYZh/4waJlNE8K38O4/T+6Xfeu2Q5QiH/EB5ImaA3czT0SkgwUoj5X5P3UfYdBKY2RjTVo3sL9CVPQTQMvbkPpeosBpPz2tJwUOjv+0/HjL0HEUuVwNez33glWshyLskkI2D2A3MptqqswIoO52pKEW+9KWnCyY/xNWthXM7Qol8aCB3JamcW6zYZzvI+LKvfexpbb6bY8+Nnbc2UgmQMsXCARTpw5X/nfWXg92f91ThYqdZC9lNSMs0a39kOlJ6eOCFTlEfoCqZSZp6FZ5TjhjgJ6yFkq6azxJzYU8/qzeMRgQ+YWwyV0TC/JjZ+SSfVITdGalnQhTm61pY7YFqg1AQA78LjqbAlP4BZtAcLsmtsHBsd3/MeOxhh5ny7Ckcp6PsYEOBDFZPeOMHdTn1x4tDlVF38l9nNhmTvQx7PcV0WKQgDNYu6u5ygRtAN8yfB9pMEY+9eEUTRJ9C8TDRACvaoCUkZDJ/3inh5ZN1shkCwp9bfJOXzPuL/FB51o/02EMtSl48KPAGMD59sM0SGXdfElo3hDesATiMDUbbyiSNsvxYjPfZQK+BagED26z3VHPYxGkbRUyM5j4hqSaiC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(8676002)(7416002)(66476007)(4326008)(5660300002)(2906002)(38070700005)(2616005)(64756008)(66556008)(66446008)(4744005)(36756003)(71200400001)(83380400001)(26005)(53546011)(6506007)(6486002)(6512007)(186003)(508600001)(122000001)(38100700002)(86362001)(76116006)(6916009)(54906003)(66946007)(33656002)(316002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzdwN0tDazZmQUx5NDVyK3RWSVY0dExrNXpmdUk1L09YTTFUaGwzdTlhdzBK?=
 =?utf-8?B?VEIrUzk1UXZqQlBWa0FLbDJGblZEeEJKcDNwaHJmMHd5NFVXZ2JRQkZTRlVW?=
 =?utf-8?B?dVFZTllyUnVCcTNUVGJYaG8yTDBNUzdzaUkzZ1YzU09XVDNWVXZ6NmFNYzVj?=
 =?utf-8?B?ME43STBGeS9TV1JIeVpyN2d5TEN3ckpnK0JzNkg3RzBSR0ZpNDFOMzVlU1NV?=
 =?utf-8?B?RzNCMDdRZTArMCtVWVFwQlpyRnVGQWRqVXFMQUVmN01keDdxd1I0WUsyR2Zq?=
 =?utf-8?B?SFAzYnd5WTBWaVpld3Z5UXlQYytCTW9LQWpMWkNwekl1UFFIVThaTHBJREoy?=
 =?utf-8?B?dGY2K1JiSXhZOTdNd1kwLzNjZlZ6Q3hzVUVZaVFNSkFNdktkWmRhWTEwTEli?=
 =?utf-8?B?aWhJZ2ZaSEYyYngyQWtpYzZtMyszcE5vUlZLL3ZNMXNRa0RsY3hCRTc4T3h4?=
 =?utf-8?B?UHlITGNlMkRWRDhhNzUvbkxueEk4SjM1b2FNMkhIRVRaRzNBYjJNSFhkbmc4?=
 =?utf-8?B?b3YvcFRaZDFhZ1NkUU45S054ZDgvZzV3eUxuNWE5eUhRODVLZTlyTEI1d1ZU?=
 =?utf-8?B?RTBDcTdaWmR5eWY0WjI3OHRSRlJCaTRUTWdyeUVRSVRLT1p1ZExibGZGbkM5?=
 =?utf-8?B?T2swNTEvYkpCczhic0ZlY2JncGxubjQ2UXVzaVZ4VEdMMVE3QVh1eDZIVVRp?=
 =?utf-8?B?b00wT3dVZy9RTW9laWxVTWZqWk9FTjUyZ2ZvWVUvUU1OczVxZ0ZXUkpoUE5X?=
 =?utf-8?B?bW1RL3ZVZkMvZkdrZnJuUXIyaEQ1LzFlV3lFNDhuZjJIcHdTYzJvR1FucEpr?=
 =?utf-8?B?YjhKQzFiWUgyRXlWaG0rWW1VQlhTdHd4SXFVWWRJV2l5eGx3RzZteXZzc1kv?=
 =?utf-8?B?aG9HcFBlMStKWmM5cVEyVW1XdHpxc0NCTkNjbDVkNU53YU1hOXRuVjdjczI2?=
 =?utf-8?B?YU5LRjFFQTBSS09ITTRycGdLTHBHQWZQVFpEZDU0Qi9HTzNYMUxZQzVzdGdY?=
 =?utf-8?B?bVAwZnhra0cvb1RDbVhVVVhyQUpYUXN6eGxaQzVQRy9vaXZ0NGsxWktxbjR3?=
 =?utf-8?B?MDhJNE9aUStzdFlqTjA2anlyYWxnWFppclRqbVhwNzV5ZFBzQlZCTzNMY3A5?=
 =?utf-8?B?Vm9uL2JIcmlrZ3ZlTXhEREgzK1lFNEc4UmxjZ2s3bHhZRTh6YlNoYzhlQzhX?=
 =?utf-8?B?VnlsbEc2a3V5UmVoUlFOSlNMYi9VeS9ibUVIWXdNTUNzaEpmOW4wY2t0U09R?=
 =?utf-8?B?OHRTbjh2a1FoL0Z1SmRyQ3B5Sk9YOWpVVWx6dG1nQVMyK3doc1BrZGFUTUNv?=
 =?utf-8?B?a1I3aG0xR0pHK1RxVkprODNRTTg5WVphQlVnMnJHZ3N4YnAxQVA5S2RLV3pn?=
 =?utf-8?B?RU85MnovZHV4bkZ0ZXFOWnM2aHFEZXYvNDl3L0l3bXpKcUMrVTlHVUVvOWxQ?=
 =?utf-8?B?QllzV08yRXlGS3V0TDcycEJ5VFluY0pnakIyOUYvL3ZxN0ppZThBU1NXSVVu?=
 =?utf-8?B?SXJ4cFJxSjRyNytZSEZzWmZsUVBkeFJ2REd5MmVsVzRyWVNKOWVINkFHbzJY?=
 =?utf-8?B?LzVGSVpKNW5rck1hTC9JR0xUVEwyYmJjNERPWERUdmR5a0dSWmgvblcwTmF5?=
 =?utf-8?B?RGJHTjYyQmN2YnlzTVFVNHdwd1h2NDh2WTdsK2lQdTMrK0Z1MEZkRmwxY0Ir?=
 =?utf-8?B?RWNNSHMweWR2ckFldzRQUGw0V2EyMHU1YVdpdXJ4TVBnMlZLQVlVbmNFa2Ix?=
 =?utf-8?B?eFJ4UmlnYVA3MDJoR3BoUVlQWXNIdTQzVHZuZ01WSGhIYVlraXdaWC9KNHdy?=
 =?utf-8?B?cGN0eGdYMGp6THhYUCs1blFtV0RrMFVYRlhCdWRaSjMxbEYrajBLbHMwUllC?=
 =?utf-8?B?d1NSb1pnTmFPYzI2ay93U2h2NlIreThzT1BZQ0Vtc1FpUHQvMThUUmV5dTdx?=
 =?utf-8?B?UVRGQmZuOUliMXpuUWJLU0pRZHhyMVpxbWgveVFseUZwSVFaSEpYSEl4bEda?=
 =?utf-8?B?NjMrL3VQYzE2Y0tZWTJXdWJKbE54R2Zha29oZFBTMU9KWGVZRGFaTEg0M1hX?=
 =?utf-8?B?Q1hZcHNBbDBmbDZDN2pQWG5xM1A3WXUxR3NUakVqNW5NK1AxZUFpWjdIcCtZ?=
 =?utf-8?B?R2Y5MFBwTUtCaTZxa1NCcUNnTW9JSXVTMCt4bkU0eCtQenBRamNjZ3dNT3Jv?=
 =?utf-8?Q?XqIGAck6VTAAx/VY4tU7Yu8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C859CC7A0C1E4B8E5E6C9BACD3BB0B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a79ad70-1e79-4ef7-fb8f-08d9c1b867dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 23:53:20.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvjqcezMCfko7q76iM/3qU5XG89w+EiA8H+v03ZKul5fLaLSajsD4fxKWUHeJJAU/QhQCrB5f6TJaWCpjcO3bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB2985
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IE9uIERlYyAxNywgMjAyMSwgYXQgMzoyOSBQTSwgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlk
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTcuMTIuMjEgMjM6NTgsIExpbnVzIFRvcnZh
bGRzIHdyb3RlOg0KPj4gDQo+PiBBbmQgeW91IGNhbid0IGV2ZW4gZG8gdGhlIG9wdGltaXN0aWMg
Y2FzZSB3aXRob3V0IHRha2luZyB0aGUgbG9jaywNCj4+IGJlY2F1c2UgaW4geW91ciB3b3JsZCwg
YSBDT1cgdGhhdCBvcHRpbWlzdGljYWxseSBjb3BpZXMgaW4gdGhlIGNhc2Ugb2YNCj4+IGEgcmFj
ZSBjb25kaXRpb24gaXMgZnVuZGFtZW50YWxseSAqd3JvbmcqIGFuZCBidWdneS4gQmVjYXVzZSBp
biB5b3VyDQo+PiB3b3JsZC12aWV3LCBHVVAgYW5kIENPVyBhcmUgdmVyeSBkaWZmZXJlbnQgYW5k
IGhhdmUgZGlmZmVyZW50IHJ1bGVzLA0KPj4gYnV0IHlvdSBuZWVkIHRoaW5ncyB0byBiZSAqZXhh
Y3QqLCBhbmQgdGhleSBhcmVu4oCZdC4NCg0KSSB1bmRlcnN0YW5kIHRoZSBkaXNjdXNzaW9uIG1h
aW5seSByZXZvbHZlcyBjb3JyZWN0bmVzcywgd2hpY2ggaXMNCm9idmlvdXNseSB0aGUgbW9zdCBp
bXBvcnRhbnQgcHJvcGVydHksIGJ1dCBJIHdvdWxkIGxpa2UgdG8gbWVudGlvbg0KdGhhdCBoYXZp
bmcgdHJhbnNpZW50IGdldF9wYWdlKCkgY2FsbHMgY2F1c2luZyB1bm5lY2Vzc2FyeSBDT1dzIGNh
bg0KY2F1c2UgaGFyZC10by1hbmFseXplIGFuZCBoYXJkLXRvLWF2b2lkIHBlcmZvcm1hbmNlIGRl
Z3JhZGF0aW9uLiBDT1cNCm1lYW5zIGEgcGFnZSBjb3B5LCBhIFRMQiBmbHVzaCBhbmQgcG90ZW50
aWFsbHkgYSBUTEIgc2hvb3Rkb3duLCB3aGljaA0KaXMgdGhlIG1vc3QgcGFpbmZ1bCwgc3BlY2lm
aWNhbGx5IG9uIFZNcy4NCg0KU28gSSB0aGluayB0aGF0IGFueSBzb2x1dGlvbiBzaG91bGQgYmUg
YWJsZSB0byBsaW1pdCB0aGUgY2FzZXMvbnVtYmVyDQpvZiB1bm5lY2Vzc2FyeSBDT1cgb3BlcmF0
aW9ucyB0byBiZSBtaW5pbWFsLg0KDQo=
