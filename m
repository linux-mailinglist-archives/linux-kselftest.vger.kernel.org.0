Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74789479E85
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 01:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhLSATi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 19:19:38 -0500
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com ([104.47.56.169]:6153
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229641AbhLSATh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 19:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKtSHkaCXtyF35LLprlvQoSwIdiGf91GLYBpjiVD4mBl1x6acErpyxEpmE7ggzYgdRQJPiplBgueel9sB5wTHyI5j/wX3oTBWVO2OOEmU/R3l0FsRk/HU37lGHOVfpNfoK4OaqeGVuWxbRQ/MdT6PO08yHX+zSUQUpC9x8wv7mGmOHXAkgyUlGOZrhkyi0Dp0Lb5YxG0UZsWkNWodpcD8Rig/rVFRE1l4RynEQmtSy1+qySSnMK86l5LdIrBLE9PskzzFxeOMT31UBMbW7ACcyZ25DDcPRg0DKyRQmfV1TazxoZpuWK+e7hDHQq+jl9rzwME4Fnn3BxclMpiz+GZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxAFAR8pyIUyT56DWU/Sa8A/9Li0S60f67BgaZyQHi4=;
 b=Eo+LMK+GZo18GabjiBGn/5p9wOlhMknLAHeVfiDEnr1jdTIfo05mU/LEHwrzRB37sEAgQtdn7J7ROLAwvDlGrvFtqRzjKSl1B0XfH9mMQIzk5xOfoNH+uXkEkWC177AiKSpgyCkr7fbhzjCxc/G31cBAkU9IdwQ1Ku08yWo3HYgwLtfhSthHEvl2bxr9hVL1TvPlh+2m/ECLxq8iPnZjYOEH8AqxW5Bc8TlqAHA2cEi2PJRvK+/0q+OrHH8OJHpOoXKnKgKWsYRplY3RIedp/T+pIv5fiuV7oiB2P2Kzo1HnFkWSMt2J9SrnFdOrCsbLpUb/TpXBziPZ7sRe6BpLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxAFAR8pyIUyT56DWU/Sa8A/9Li0S60f67BgaZyQHi4=;
 b=iGJrwYbz2ehOdQxtrEfw6cOqaYLgobacOT4hLnm+hfrbxbIQQJMIA3/ah2bsqcRjpeMthwfi7gzEPCqTKbRoxmzjouarS5JJUqfuYNpHrA2Jcc4ChJJTUb6RGVSJWmFJCzV7J13lMGedwEL4VdgbAKtZbsrsD02M8bpTya+m/tg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA1PR05MB8375.namprd05.prod.outlook.com (2603:10b6:806:1d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.7; Sun, 19 Dec
 2021 00:19:34 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.013; Sun, 19 Dec 2021
 00:19:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAFCICAAA9rAIAABT2AgAAC5YCAAAgCAIAATa2AgAAT84CAAAcTAIAAAkmAgAD8jICAADQXgIAAEhAAgAAYAYA=
Date:   Sun, 19 Dec 2021 00:19:34 +0000
Message-ID: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
References: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com>
 <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com>
 <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com>
 <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214af18f-7fdb-4491-c565-08d9c2853c24
x-ms-traffictypediagnostic: SA1PR05MB8375:EE_
x-microsoft-antispam-prvs: <SA1PR05MB8375AA56A44BCFCFAEFC6EABD07A9@SA1PR05MB8375.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DVtJI/YFSmtWrgHlmxoPzoq8C9fgfHqLMozwA0iBFAj4eVQBFvaNblLDziZhb0e7FzFTsnj/jSxhP5iPBEPu1x/gtZIPjveH6ULoSV6QoBkZk0JzD79EjgWAZJoiYPclJSFAtwM6DkER7Cwhv25zryNkBiLE1uRo35dRjRsr/WInwGSmDGi3EwN2zWE0HNBitFHthPNLkTsTyIKAEyiCCkkydMABwNAMDsmolum7PoQeRR8iKW3mEILLWFX87+NmTj3LkBo4/JL2PLdfWTnNDXyebElRycgFDfjCocCT7SiYsR8FYp6MZVHjKXd1S/V24lT2vRQmJKIRTtY6lF/40GJSxxy+0HoYHB11DkX94QTGSpEmpHXR19h2Mb13Ns4/DV+QZa+VG0n8SjYgFEYho1BGS4yrwgDzOjQSDYKk8962LYWD2fMkxFSAtZ7IEId8Q3VXJ/RlTGSgXOcV34qwZcX3+YxgM27IVIIoevvnOL631Kb44X1t2LvlwKxed6ajp2OK2w2GO7grRo8Vpe5arR0ZTdSzzrwY9NqgB7YuVA7/w0V4Fr+o9aqKC5XbmSGkuHBCsuT4zosSnA9aNUPf7Cf1yRcgaqrSXBJzsGNURmZKKrlTE22CuwKKxPLl1wRoJmJaVaxv5S/LE5T933FA0IdSZMHlqUX8yW4Ht5FfBTg4zxPML887JHLYpIYLIDlZCAPkp/mEbRolrXnZ5+vvF6uHZY+WXRX/wilT0f8Lss5sWBwEs48qZudui507J47g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2906002)(71200400001)(7416002)(83380400001)(36756003)(508600001)(5660300002)(76116006)(8676002)(6506007)(6486002)(53546011)(38100700002)(2616005)(122000001)(8936002)(66946007)(6916009)(38070700005)(4326008)(66556008)(66476007)(64756008)(66446008)(86362001)(54906003)(316002)(186003)(26005)(6512007)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlBvMnY4OTB1MmNjYUE1djBxbXBwYVVFRGhseDgwaGdkSTZLblJKVkpZZzhC?=
 =?utf-8?B?RGl2N21JeGQrV3FjMmRXMkg5aGtmdHQwclowOVZ1bzdaWVZhakpudHpjMWRY?=
 =?utf-8?B?RG5nbm1zc3RxTk5IMndRZng2cHMxL2JER0xRejBXVDJjbXpNNnE2YjhZOEpa?=
 =?utf-8?B?YVRiZ1ZheTJYMG9OMENvWXhWN0J4ZlNyWHl1WUVYaXRlS25wUVZIV1dVaFhM?=
 =?utf-8?B?aUFhbEV0a05DTDNSYVladC9ia3BnRDNDV2cyd3ArMm5hQ1BUd21xTGQ1Q1FC?=
 =?utf-8?B?YkZDLy8vVU53b1R3MUdta3M5YTlIbmhyYkovVzgzL1A5R3BRODBqaU1KdjIr?=
 =?utf-8?B?d0FkajRjdVNWSlY2SDBhNWdXWXRUYjFTV003V1czUk1oZWp1cDRjYmFSRjFx?=
 =?utf-8?B?QXVIUEp4b1c5dnUvL25DSlJ2Q0pkdGZNbE10L1JnZVRJYUhZYUtWSHgvV2Nl?=
 =?utf-8?B?cUlMWXdUaHlXbDNmVm0zTzhya2h4MmFZY1Y4eTgzUWI5bDUwZkJDdVRJNjVP?=
 =?utf-8?B?K1dhdmREcmpvZ3RSeEZCb3RWa2s0Skd5M2NVNUsxcVBMK3FBRWFkYVlIeDds?=
 =?utf-8?B?T2pkb240SlZLR3NmTm5YYnRDN3A4YjdZRGpON1RkdlBxRGNZdjlhU3VSU1lz?=
 =?utf-8?B?NEdJOGMyM0Z4Z09rRTFySzdkcWJ2aDlGU1I2M0xvTXNjZ3hJdkVlY3F1d1l2?=
 =?utf-8?B?UVV1OXNoR240dk9NOFdtYXFJVlRFNnhydkQ4N1dhRWdEbjRkSzZsK3FDZ1Q5?=
 =?utf-8?B?b2x4SGxKYk5tN3A1eWhWUEcyc0tjVHEzMXFyNjJZektrNWhPN0FRbHRFaGo2?=
 =?utf-8?B?QlY3SjZPVVZyWWI4T3daY2ZmRjdPNzB6NWpTT3lYRVpWNUlwbitTTDJRQmh5?=
 =?utf-8?B?M2NwdExXS1RpUnBUUmhGanRZZk13SW9BamtNUjhRdUdKMFRaWWl2Qlg5MGZC?=
 =?utf-8?B?cjBmSjJPcXZrUlpSVE5JOVBIVFNHMldvRDdZRDk3ZXFtd3dEVHpkTmQ5QVhj?=
 =?utf-8?B?Sk9yang3MGNNcWZPSjQxQXNFa3Y5YmVoRzZMbnA3MVExOTBNMVJMczdKcEJ0?=
 =?utf-8?B?aHMyWTZIZXk0c0hRMWRCMkV5K1lRSTI2UGthbWR0eGFTU0wxNXo0N216NEs1?=
 =?utf-8?B?Qnc3NERFdnVhOTNRRDJEcVU3azViS1d3c1hobG5ub1gxYS9jVTVHWk9iOWNx?=
 =?utf-8?B?MVl1NnlrVjI1SkdtRFYwVy9Tb2lDOWhONU1FQ3BsajBRbzQ1dllSRGVoTlUz?=
 =?utf-8?B?Q0Z2YkRiZGpMUE9nQ2xPVkt4bkZ1bzNJN0Z0MWErRjA2WmRINVhoZllEUEIx?=
 =?utf-8?B?QlV3aFkweU5IN1VYZWdaOUhZRXNwUy9YTHNnblM4M2FsRFRXL09qZ0NuZ0wy?=
 =?utf-8?B?SGx3cFIrbWU3QUIwNnV0LytaRk56ZnVuY1JDdjQrK1MyWlgrYUdnbDhzd2gv?=
 =?utf-8?B?SmVmSzhwbFNOZEVWSVI1dzdZamxObEZramQ2MGJUa0pJOGZlcEhkc1NZLzZS?=
 =?utf-8?B?V3hneThoL0E4V2d2QTZ5dW9tSDdmczFjcm5zZFR0UW9zZVN1cDZSa002MFFz?=
 =?utf-8?B?d0F4SHF5RmFxY2lVeTB1SThoYncxZ1NvOHZzUWJvakZ5SjFabndXZDZzU0RT?=
 =?utf-8?B?RHZzclhPSTlTUGVsRG95QzJiVU9UQjE3QlNNemJBbk4rREl1OGp0MGdzVmZ6?=
 =?utf-8?B?dllXbmpuVHN2ckc5L2tMZmsxLzZ1N0lmTWsreUF1VE96U0wwSldsVWVZMm54?=
 =?utf-8?B?VU5SUDh6aUJrYW1KMTlZeVVRNWk0dXJ3NU8rdHdweE5qaXgxcXRzVi9PQTRQ?=
 =?utf-8?B?Z1JYOFgvUkNRZ2paWWEzcFNtcHI2ZThSM1lyd2hMS1pxb2ZJYytoVjg5RHpj?=
 =?utf-8?B?M2h3TmpuQmZtWnd1WGRIK2FqOTRRS3FuVk1vUXVDNlVOQVF1SGZZREJyUTlS?=
 =?utf-8?B?dUkxYXlWNWt6eEMrYTJDRUlaaWdURVFtTFhvY2ZHdGZOMFlRVCsvSUFLZjQy?=
 =?utf-8?B?aWlmUGQvbll3N3RBTDY3K0tjY29tUElqUU5yRi80QkRGUktSQjNkcVR1bXhl?=
 =?utf-8?B?VEIyUFV2bXlVdzRtRjdXa0s2Rlp0S3Yzd050OWJZWnhqZVAzeG5IdzZYaDB2?=
 =?utf-8?B?bFM2a3FlbHltcXlTOVh1Zzh4M2ppNXYxR2lFcWRRTzFpUHN3OGtpMjhjZEZ2?=
 =?utf-8?Q?DjtALwH/hyC6qZZUVRYbTlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE8A2975CA90E54791D69383880B4F72@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214af18f-7fdb-4491-c565-08d9c2853c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 00:19:34.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZH1BeM8IAlcXEGJJQgdjWjfoU6PtW1CTqq7VnzBtyIgoX7b9S1Ai1peccus5u7y8C4bgmEeJdFvBwM++jXsSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8375
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gRGVjIDE4LCAyMDIxLCBhdCAyOjUzIFBNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gU2F0LCBEZWMgMTgsIDIw
MjEgYXQgMTo0OSBQTSBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IA0K
Pj4gWWVzLCBJIGd1ZXNzIHRoYXQgeW91IHBpbiB0aGUgcGFnZXMgZWFybHkgZm9yIFJETUEgcmVn
aXN0cmF0aW9uLCB3aGljaA0KPj4gaXMgYWxzbyBzb21ldGhpbmcgeW91IG1heSBkbyBmb3IgSU8t
dXJpbmcgYnVmZmVycy4gVGhpcyB3b3VsZCByZW5kZXINCj4+IHVzZXJmYXVsdGZkIHVudXNhYmxl
Lg0KPiANCj4gSSB0aGluayB0aGlzIGlzIGFsbCBvbiB1c2VmYXVsdGZkLg0KPiANCj4gVGhhdCBj
b2RlIGxpdGVyYWxseSBzdG9sZSB0d28gb2YgdGhlIGJpdHMgZnJvbSB0aGUgcGFnZSB0YWJsZSBs
YXlvdXQgLQ0KPiBiaXRzIHRoYXQgd2UgY291bGQgaGF2ZSB1c2VkIGZvciBiZXR0ZXIgdGhpbmdz
Lg0KPiANCj4gQW5kIGd1ZXNzIHdoYXQ/IEJlY2F1c2UgaXQgcmVxdWlyZWQgdGhvc2UgdHdvIGJp
dHMgaW4gdGhlIHBhZ2UgdGFibGVzLA0KPiBhbmQgYmVjYXVzZSB0aGF0J3Mgbm9uLXBvcnRhYmxl
LCBpdCB0dXJucyBvdXQgdGhhdCBVRkZEX1dQIGNhbiBvbmx5IGJlDQo+IGVuYWJsZWQgYW5kIG9u
bHkgd29ya3Mgb24geDg2LTY0IGluIHRoZSBmaXJzdCBwbGFjZS4NCj4gDQo+IFNvIFVGRlNfV1Ag
aXMgZnVuZGFtZW50YWxseSBub24tcG9ydGFibGUuIERvbid0IHVzZSBpdC4NCg0KSSBoYXZlIGFs
d2F5cyBmZWx0IHRoYXQgdGhlIFBURSBzb2Z0d2FyZS1iaXRzIGxpbWl0IGlzIHZlcnkgYXJ0aWZp
Y2lhbC4NCldlIGNhbiBqdXN0IGFsbG9jYXRlIHR3byBhZGphY2VudCBwYWdlcyB3aGVuIG5lZWRl
ZCwgb25lIGZvciBQVEVzIGFuZA0Kb25lIGZvciBleHRyYSBzb2Z0d2FyZSBiaXRzLiBBIHNvZnR3
YXJlIGJpdCBpbiB0aGUgUFRFIGNhbiBpbmRpY2F0ZQ0K4oCcZXh0cmEgc29mdHdhcmUgYml0c+KA
nSBhcmUgcmVsZXZhbnQgKHRvIHNhdmUgY2FjaGUtbWlzc2VzKSwgYW5kIGEgYml0DQppbiB0aGUg
UFRFcycgcGFnZS1zdHJ1Y3QgaW5kaWNhdGUgd2hldGhlciB0aGVyZSBpcyBhZGphY2VudCDigJxl
eHRyYQ0Kc29mdHdhcmUgYml0c+KAnSBwYWdlLg0KDQpJ4oCZdmUgZG9uZSBpdCBzb21ldGhpbmcg
c2ltaWxhciBvbmNlIGluIGEgcmVzZWFyY2ggcHJvamVjdC4gSXQgaXMNCnJhdGhlciBzaW1pbGFy
IHRvIHdoYXQgaXMgZG9uZSBmb3IgUFRJIGluIHRoZSBQR0QgbGV2ZWwuDQoNCg0KPiANCj4gQW55
d2F5LCB0aGUgZ29vZCBuZXdzIGlzIHRoYXQgSSB0aGluayB0aGF0IGV4YWN0bHkgYmVjYXVzZSB1
ZmZkX3dwDQo+IHN0b2xlIHR3byBiaXRzIGZyb20gdGhlIHBhZ2UgdGFibGUgbGF5b3V0LCBpdCBh
bHJlYWR5IGhhcyBhbGwgdGhlDQo+IGtub3dsZWRnZSBpdCBuZWVkcyB0byBoYW5kbGUgdGhpcyBl
bnRpcmVseSBvbiBpdHMgb3duLiBJdCdzIGp1c3QgdG9vDQo+IGxhenkgdG8gZG8gc28gbm93Lg0K
PiANCj4gSW4gcGFydGljdWxhciwgaXQgaGFzIHRoYXQgc3BlY2lhbCBVRkZEX1dQIGJpdCB0aGF0
IGJhc2ljYWxseSBzYXlzDQo+ICJ0aGlzIHBhZ2UgaXMgYWN0dWFsbHkgd3JpdGFibGUsIGJ1dCBJ
J3ZlIG1hZGUgaXQgcmVhZC1vbmx5IGp1c3QgdG8NCj4gZ2V0IHRoZSBmYXVsdCBmb3Igc29mdC1k
aXJ0eSIuDQo+IA0KPiBBbmQgdGhlIGhpbnQgaGVyZSBpcyB0aGF0IGlmIHRoZSBwYWdlIHRydWx5
ICp3YXMqIHdyaXRhYmxlLCB0aGVuIENPVw0KPiBqdXN0IHNob3VsZG4ndCBoYXBwZW4sIGFuZCBh
bGwgdGhhdCB0aGUgcGFnZSBmYXVsdCBjb2RlIHNob3VsZCBkbyBpcw0KPiBzZXQgc29mdC1kaXJ0
eSBhbmQgcmV0dXJuIHdpdGggdGhlIHBhZ2Ugc2V0IHdyaXRhYmxlLg0KPiANCj4gQW5kIGlmIHRo
ZSBwYWdlIHdhcyAqbm90KiB3cml0YWJsZSwgdGhlbiBVRkZEX1dQIHdhc24ndCBhY3R1YWxseQ0K
PiBuZWVkZWQgaW4gdGhlIGZpcnN0IHBsYWNlLCBidXQgdGhlIHVmZmQgY29kZSBqdXN0IHNldHMg
aXQgYmxpbmRseS4NCg0KSSBkb27igJl0IHRoaW5rIHRoYXQgSSBhbSBmb2xsb3dpbmcuIFRoZSB3
cml0ZS1wcm90ZWN0aW9uIG9mIFVGRkQgbWVhbnMNCnRoYXQgdGhlIHVzZXJzcGFjZSB3YW50cyB0
byBpbnRlcnZlbmUgYmVmb3JlIGFueXRoaW5nIGVsc2UgKGluY2x1ZGluZw0KQ09XKS4NCg0KVUZG
RF9XUCBpbmRpY2F0aW9ucyBhcmUgcmVjb3JkZWQgcGVyIFBURSAoaS5lLiwgbm90IFZNQSkuIFNv
IGlmDQp1c2Vyc3BhY2Ugd2FudHMgdG8gaW50ZXJ2ZW5lIG9uIHdyaXRlLCBpdCBtdXN0IHVzZSBV
RkZEX1dQIGV2ZW4gaWYNCnRoZSBwYWdlIGlzIHdyaXRlLXByb3RlY3RlZC4gVGhlIGtlcm5lbCB0
aGVuIGhhcyB0byBrZWVwIHRoZSBVRkZEX1dQDQppbmRpY2F0aW9uIHRvIGNhbGwgdXNlcnNwYWNl
IHVwb24gYSB3cml0ZS4NCg0KDQo+IA0KPiBOb3RpY2U/IEl0IF9zaG91bGRfIGJlIGp1c3QgYW4g
b3BlcmF0aW9uIGJhc2VkIHB1cmVseSBvbiB0aGUgcGFnZQ0KPiB0YWJsZSBjb250ZW50cywgbmV2
ZXIgZXZlbiBsb29raW5nIGF0IHRoZSBwYWdlIEFUIEFMTC4gTm90IGV2ZW4gdGhlDQo+IHBhZ2Ug
Y291bnQsIG11Y2ggbGVzcyBzb21lIG1hcGNvdW50IHRoaW5nLg0KPiANCj4gRG9uZSByaWdodCwg
dGhhdCBzb2Z0LWRpcnR5IHRoaW5nIGNvdWxkIHdvcmsgZXZlbiB3aXRoIG5vIHBhZ2UgYmFja2lu
Zw0KPiBhdCBhbGwsIEkgdGhpbmsuDQo+IA0KPiBCdXQgYXMgZmFyIGFzIEkga25vdywgd2UndmUg
YWN0dWFsbHkgbmV2ZXIgc2VlbiBhIHdvcmtsb2FkIHRoYXQgZG9lcw0KPiBhbGwgdGhpcywgc28u
LiBEb2VzIGFueWJvZHkgZXZlbiBoYXZlIGEgdGVzdC1jYXNlPw0KPiANCj4gQmVjYXVzZSBJIGRv
IHRoaW5rIHRoYXQgVUZGRF9XUCByZWFsbHkgc2hvdWxkIG5ldmVyIHJlYWxseSBsb29rIGF0IHRo
ZQ0KPiBwYWdlLCBhbmQgdGhpcyBpc3N1ZSBpcyBhY3R1YWxseSBpbmRlcGVuZGVudCBvZiB0aGUg
InBhZ2VfY291bnQoKSB2cw0KPiBwYWdlX21hcGNvdW50KCkiIGRpc2N1c3Npb24uDQoNCkkgY2Fu
IHRoaW5rIG9mIHR3byBleGFtcGxlcyBmb3IgcmVhc29uYWJsZSBmbG93cyBvZiBVRkZEOg0KDQpb
IE0gPSBNb25pdG9yIHRocmVhZDsgIEYgPSBGYXVsdGluZyB0aHJlYWQgXQ0KDQooQSkgVXNlcnNw
YWNlIHBhZ2UtZmF1bHQgdHJhY2tpbmcgKGUuZy4sIGZvciBtZW1vcnkgbWlncmF0aW9uKToNCg0K
MS4gTTogV1AgbWVtb3J5Lg0KMi4gRjogV1AgcGFnZS1mYXVsdDogcHJvdmlkZSBVRkZEIG5vdGlm
aWNhdGlvbi4NCjMuIE06IFVucHJvdGVjdCB0aGUgcGFnZS4NCjQuIE06IFdha2UgdGhlIGZhdWx0
aW5nIHRocmVhZCAodXN1YWxseSBhcyBwYXJ0IG9mIHRoZSB1bnByb3RlY3QpDQo1LiBGOiBSZXRy
eSB0aGUgcGFnZS1mYXVsdCAoYW5kIGhhbmRsZSBDT1cpLg0KDQooQikgVXNlcnNwYWNlIG1lbW9y
eSBzbmFwc2hvdHM6DQoNCjEuIE06IFdyaXRlLXByb3RlY3QgbWVtb3J5Lg0KMi4gTTogQ29weSB0
aGUgbWVtb3J5IHRvIGRpc2suDQozLiBNOiBXcml0ZS11bnByb3RlY3QgbWVtb3J5ICAoZS5nLiwg
c3BlY3VsYXRpdmVseSBhcyB5b3UgZXhwZWN0IGEgcGFnZQ0KICAgdG8gYmUgd3JpdHRlbiB0byBh
bmQgZG8gbm90IHdhbnQgdG8gcGF5IHRoZSAjUEYgcHJpY2UpLg0KDQogICBbIG5vdGljZSB0aGF0
IHRoZSB1bi1wcm90ZWN0aW9uIGlzIGxvZ2ljYWwsIG5vdCByZWFsbHkgaW4gdGhlIFBURXNdDQoN
CjQuIEY6IEdldCBhIHBhZ2UtZmF1bHQgKGxhdGVyKSBhbmQgaGFuZGxlIGl0IChiZWNhdXNlIGl0
IG1pZ2h0IG9yDQogICAgICBtaWdodCBub3QgbmVlZCBDT1cpDQoNClRoZXJlIG1heSBiZSDigJxj
cmF6aWVy4oCdIGZsb3dzIChlLmcuLCB3YWtlIHRoZSBmYXVsdGluZyB0aHJlYWQgYW5kDQplbXVs
YXRlIHRoZSBpbnN0cnVjdGlvbiB0aGF0IHRyaWdnZXJlZCB0aGUgd3JpdGUgd2l0aCBwdHJhY2Up
LCBidXQNCmxldOKAmXMgcHV0IHRob3NlIGFzaWRlLg0KDQpJSVVDIHRoZSBzb2x1dGlvbiB5b3Ug
cHJvcG9zZSwgaXQgdHJpZXMgdG8gYWRkcmVzcyBmbG93cyBzdWNoIGFzIChBKS4NCg0KSSBhbSBu
b3Qgc3VyZSB3aGV0aGVyIHRoZSBwcm9wb3NhbCBpcyB0byBjaGFuZ2UgdGhlIHdyaXRlLXByb3Rl
Y3Rpb24NCkFQSSB0byBvbmx5IHByb3ZpZGUgbm90aWZpY2F0aW9ucyAoaS5lLiwgbm90IGJsb2Nr
IHRvIGFmdGVyIHBhZ2UtZmF1bHQNCmFzIGRvbmUgdG9kYXkpLCBidXQgSSBkbyBub3Qgc2VlIGhv
dyBpdCBhZGRyZXNzZXMgKEIpLg0KDQpJIGFtIG5vdCBzYXlpbmcgaXQgaXMgaW1wb3NzaWJsZSwg
YnV0IEkgdGhpbmsgdGhhdCB0aGUgc29sdXRpb24gd291bGQNCmNvbXBsaWNhdGUgdGhlIGNvZGUg
YnkgbWFraW5nIFVGRkQgYSBzcGVjaWFsIGNhc2UuDQoNCg==
