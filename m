Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051D479FB3
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Dec 2021 07:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhLSGCE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 Dec 2021 01:02:04 -0500
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com ([104.47.55.176]:6130
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235280AbhLSGCD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 Dec 2021 01:02:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mASRc/Mhd5+b0gv1/JDlqfTG79xSIw16X18AbS0uld03fmD6eeRdEyz1coUK0MCesoSlpBKPwJbHTc78NLC1R5Zr99oyIKMmFScYjPh2mRoZR+8dZdLzbPeXt4M8fgZG5NxoyC5kzD/fKfReQ3dHYV3RHhEFO+Wh/ayzo18uxR5xCught33U3pnu81PSN5Lu+R19ENCxONHksx3vy0yM7saahL2YbMsnivIgulVCSW5yHSXw1a5SS+kxLEIywpt1BG1MyplHpRcpFwlR2J1/cOgVfV00ZYDogVQ21EIQIX9Ujdb45+1X023Q++SU4/91N92/9P4YT4wuKJxy0VFXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKwniZwtnTctqKD5CxFjjOR2ZViBnfYMgIQ8Cux5c+M=;
 b=gCcfGV6c1blMkiXg68LrPCi4szJAiP6AdSkg7CJDy89HGuhk59EsCzTlmDgbaRD/VF44YDE3w2UGFs/xWnmpV3hpHzJhyRwSY53m+LErlMluaUMNz01m1ExL39d6prZeqgMBfd1nnbEoIunzIDWd4IVNsuL5iSeMQWnDck4nN6n7NovAWMOPtafmwJwB9FSd3MJFI2y3GWQ92o2GQNZ3eNH6UWs1X4eKGizPJcmGc0n6bLzStYw1Poy5PWK9iT0bO6ScVo8F0mi53SLbYyjkXWOVj8AMrw4xBsx2pKPlZPE/0IKtZ9m1k830BZqm/8k0Tvaf7SdCXoKoVemYYCxPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKwniZwtnTctqKD5CxFjjOR2ZViBnfYMgIQ8Cux5c+M=;
 b=nlFTuFoB5Yf2nGgOpeIUkAfwynMbnfy/TVDjKbClhNEGbI6gbaHqjj0K8Taq+UmTdO/Hc1tg6Hwf8+hyLPhhy56PNWKmknoHHYwHlO+Ubaj4RBpVX6MxZrhjsgLF30ctRn32a4u7GUUC1qkmIEtTIKiy0YaLkgGbl0bM+gRvKAE=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6218.namprd05.prod.outlook.com (2603:10b6:5:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Sun, 19 Dec
 2021 06:02:00 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.013; Sun, 19 Dec 2021
 06:02:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAFCICAAA9rAIAABT2AgAAC5YCAAAgCAIAATa2AgAAT84CAAAcTAIAAAkmAgAD8jICAADQXgIAAEhAAgAAYAYCAAASHgIAAWyGA
Date:   Sun, 19 Dec 2021 06:02:00 +0000
Message-ID: <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com>
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
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
In-Reply-To: <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca3ec8e5-ce7e-4dee-ada0-08d9c2b5127e
x-ms-traffictypediagnostic: DM6PR05MB6218:EE_
x-microsoft-antispam-prvs: <DM6PR05MB621825A8516F380ED9882B1FD07A9@DM6PR05MB6218.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TnRJdNS5DKVF78M6EWNBOQCRrwqw964U9A9gzkvW0RHKlMK0ytC2qM6SKGw+ZTLkX5BOa6cJCdyLQw83ajoxPka4ro7fhY32Y/wzgx1X4AMtKlZLHilTa3O65NbeA5yIyTKoibsSC47jVlsCEJAYC0f9/kJn5hVTN85ZFBxndq3KnUHe0VeF1PPyzP5JmQEL0Nft9+giTdz6fQWXLiP9dS/Ld72AlGkZz+0yPHl4uqfr23/1cOdFVvGiTKcH02TwL8FDM2S4i//eXAkJH/tHmjAkRIN9HQMFYPQpvDOwxKxQsVS7/5PEBrYyszX3/rGBIurGJ7UyJMCrmyGJt1vm1/b+cLVeJIYET5ZLpj64DgEH3zo0GINnqL4RGuia8ToE2hNKiCZqs0ysjHI6gkmYYVOrCo5Pc6Jj3nG+u0wTu0eQi9jC23rddr2OqlvMYMEcRpsXt/G/nE0M6f8HtHYdp+qwbmD9/VwmsGMTw3HCGrpNftHEgkiqsNL1k1+U83cgarCJTkpGmPidNdy5XYaFsyAw8zNdSc8gpQH8TtQaXvQbBPAXie6G/QqnxUxKNf4LIgxJNny4S1Mig0v9a7bF843Ey8QyWaarKDWNeK5EPHDzLDigbxJkrrfKXuNA/FydsU73Uvkf85wmlGsVl4yk1VZfC4B4pgD4RPfp6frkUxClm24h0OvgFeaOdyDV/rFASl+yTFpp8vi5aCf9dWE7yZza9VI5cLTb9BCmsDX5MWaSnL/BWjtZ0nwc8KDW7Fjh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(8936002)(66946007)(8676002)(66556008)(66476007)(66446008)(4326008)(86362001)(64756008)(316002)(76116006)(122000001)(2616005)(6506007)(53546011)(6486002)(38100700002)(6512007)(26005)(186003)(110136005)(54906003)(508600001)(71200400001)(2906002)(33656002)(36756003)(5660300002)(7416002)(83380400001)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RxeTM5ZVZZWGVhZUI4cGNMdWtGZUlBaEMwRGMyWGh5dnk4NzhCVmRXVm1k?=
 =?utf-8?B?VWdWS05VcnM1OGw3eVFpUk1iRFhOemYrSVBvUGR2cE9SL2x3RzU3OHdDRHJp?=
 =?utf-8?B?OE8vRFBaOEh3VHF2YnRJaERTbzhSWjBYOGs3RFA0S1ZCRUlhSTRVT1Bkc2pq?=
 =?utf-8?B?WXZCcmw3WDQ4R0dEQ0kyU2xHNE84d2RpS0dhUlFPMFd0NG5lWTJudGRaVFlX?=
 =?utf-8?B?N01BOHdmNE9IWGYzZG9qb1JjKzkxWTNaWkZzdFArSHZiWDg3a3JtMFVrOU04?=
 =?utf-8?B?SW1ZdkhHWU1hK3FKUWNKaVFEQWpTSFhmam1lV0J1SVhKa3B2QnFnVmRPRGIv?=
 =?utf-8?B?emVyK21ML0xjb3JVeGppRkpBUkdZNUJhN1lxRFlwN0c0ZVFKaHdaM3VEWlFY?=
 =?utf-8?B?SGlZaHhZMTkybEhMTG90eTBsaFRDbm5IVWJFL28zZHZZZk85UnZERlFBeUt5?=
 =?utf-8?B?UDV6S3Y0Zzh0NnB1aWtUM2QrVDNmcW5BZExmY09ZZ3luS3owQkM0MjZVNFNK?=
 =?utf-8?B?RXZGdDkrVWo0UFJHOVhqVUpIcFJ1QlhEL1A0dnMzSzBnQVNKb2RXT1l4aDJZ?=
 =?utf-8?B?OGVPRmpsLzBoNXNBM2Q0L3AxYXk5cUNpbndPL2ZYc2tobzUzRW50QnJUYmJh?=
 =?utf-8?B?UzgxNUJGaFBzTkpGTEdYMjFvT09oRXNJWXdmajNCOTBxaE03djZrUktsNGwx?=
 =?utf-8?B?VVZVSFJzNUV4cXVQdXJYTW0wbkp2VmRwRmQ5RUdhZGM0UVZuVmtzdlpJTTll?=
 =?utf-8?B?cUR6Q2pXRmFuTUEwVUNmUTVxWXZ4bjBNcVR2T2JCeVZCa3FCWDZkWjlvVWJS?=
 =?utf-8?B?bmc3eERwZlh0SmMvUVJIaklWQWM1NWpLRjhHWkhXZkcraVRld0pYV2VXMlo5?=
 =?utf-8?B?d2loV1JYblZaK1Q5eWUyWExlaTFmcXRmTmpObUNmOG0vWDVHcWV2TjMxbC8w?=
 =?utf-8?B?aFhYV1QrSDh4dEk2Z3NaQlBPeU5HSUlvSzRDY1d1WklwNzBkVG90enhxSGFa?=
 =?utf-8?B?b1d0Wm1qeWZxR21ESXVPUlEwVyttcFQveUtTZUNHSnlSRFBsd1BRWTFMMi9p?=
 =?utf-8?B?dWltTUhhYXkvTlBPbCtDQ2k3R3NabStxWDByVkZORVY5SmFaa2xKVFNFREdi?=
 =?utf-8?B?M09wRzRZM1ovQko0RW1tRjZxbTBlb1R5OEEvNmVudE5UR1dkUnJtMHV2cnpq?=
 =?utf-8?B?TEFYRjlnS2U0VnQ1dHNQTE0yczU1SEp5eGg1T1VMRDdJZ2JVWDQzaFVmY3M1?=
 =?utf-8?B?dVRDU2dCdzFyaHZvc0oxYWI5RjdiYzNycDgvdndtZk14MzViNkhJVmtxWERu?=
 =?utf-8?B?b2ZwbnhqWkpGSGN2ZXNabW82elFxQlMrNUFaSW1KbWs0aW52cEZkRGVBQk4y?=
 =?utf-8?B?QTFRNmg5eCtCcGo0Z2pzVlVOaXZ4NDFJYWFXSS9Fb0dNYW9veWRYbEVwMUlx?=
 =?utf-8?B?bVFsNllXdEh1aTNrWUhaTFFmOHZhSUhjZmpsOXJuUDJrMmgrTWtzOExDY1lY?=
 =?utf-8?B?eWN5V2kwSGtvNzgwQWFTMDB0M2g1ZVo1MTl4NCtRcitXbHhhMDlmeFFFNVBl?=
 =?utf-8?B?UjB5cldnTzNJNVBXcElJNHA3Vk9qN1Fad1pOY2tUN3I1NzQwU2xjUUtvcjlC?=
 =?utf-8?B?S1NLS3lCUDRaZUVNaC80bCs4YlExeU5mRUJoU0ZnOGQ5bWZJa1IvbmF1SmJX?=
 =?utf-8?B?dWJsWEwrekc2cHIvMU9TVEFoYTBqYWdpOFlraFZoQ25HMUVkaW9mMDVuYUFQ?=
 =?utf-8?B?bHlnOHUzNVRDbmxqUmczRSsxWXBzajV3c29PakdTNDAySXdrYkYvRFIra2V4?=
 =?utf-8?B?WWRYSFpVZ0drQitlcjRIYWFlVklMSnd3MnZoRmlOUTU2N2Rzb25OZzZZUDJi?=
 =?utf-8?B?WnJZcVA4RWJzQ0dOQlRlUmdySHVkeEdpTzZVUzVkaXNmTUVsNnVucXJRWFVh?=
 =?utf-8?B?cVBtaTJmeEZEV25aVmhreVdGdnJMakM4REZLSFczWmFIS1RxRW8yR0pkcGp3?=
 =?utf-8?B?YmYvd2huWFJEa21lRWR1R21oekcrN1h0VUdpRm5TbitOVml5T1JnbkJ5Sytx?=
 =?utf-8?B?aHlSOTFLZHc5cTZhaHRWRTkrS0Fiem5jejJWU2tLaExGRHFwU0NJeDAwei9m?=
 =?utf-8?B?ZkVuazBSRThrMW42RjJiRWZzcEVraDU3dHlaMHRMamJHZmYxWWtGQ2Q0UFg3?=
 =?utf-8?Q?POoU1l5M/EQc2zUF9m0utJk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5450454D70DFB6448BCA473FB3DFBDD3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3ec8e5-ce7e-4dee-ada0-08d9c2b5127e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2021 06:02:00.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85QJQ8f5yyX+2oSKSyYHSEQlEa4x7r2AyfGf9LJnJN+SCs8W++FfeEmN5A5iv7U9o2DnDnf9gMChKmj8rokKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6218
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IE9uIERlYyAxOCwgMjAyMSwgYXQgNDozNSBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IChJIGhhdmUgb25seSBldmVyIHNl
ZW4gdGhlIGtlcm5lbCBzaWRlIG9mIHVmZmQsIG5vdCB0aGUgYWN0dWFsIHVzZXINCj4gc2lkZSwg
c28gSSdtIG5vdCBzdXJlIGFib3V0IHRoZSB1c2UgcGF0dGVybnMpLg0KDQpJIHVzZSBpdCBpbiBh
IHZlcnkgZmluZSBncmFudWxhcml0eSwgYW5kIEkgc3VzcGVjdCBRRU1VIGFuZCBDUklVIGRvIHNv
DQp0b28uDQoNCj4gDQo+IFRoYXQgc2FpZCwgeW91ciBzdWdnZXN0aW9uIG9mIGEgc2hhZG93IHN3
IHBhZ2UgdGFibGUgYml0IHRoaW5nIHdvdWxkDQo+IGFsc28gd29yay4gQW5kIGl0IHdvdWxkIHNv
bHZlIHNvbWUgcHJvYmxlbXMgd2UgaGF2ZSBpbiBjb3JlIGFyZWFzDQo+IChub3RhYmx5ICJwYWdl
X3NwZWNpYWwoKSIgd2hpY2ggcmlnaHQgbm93IGhhcyB0aGF0DQo+IEFSQ0hfSEFTX1BURV9TUEVD
SUFMIHRoaW5nKS4NCj4gDQo+IEl0IHdvdWxkIG1ha2UgaXQgcmVhbGx5IGVhc3kgdG8gaGF2ZSB0
aGF0ICJ0aGlzIHBhZ2UgdGFibGUgZW50cnkgaXMNCj4gcGlubmVkIiBmbGFnIHRvby4NCg0KSSBm
b3VuZCBteSBvbGQgbWVzc3kgY29kZSBmb3IgdGhlIHNvZnR3YXJlLVBURSB0aGluZy4NCg0KSSBz
ZWUgdGhhdCBldmVudHVhbGx5IEkgZGVjaWRlZCB0byBob2xkIGEgcG9pbnRlciB0byB0aGUg4oCc
ZXh0cmEgUFRFc+KAnQ0Kb2YgZWFjaCBwYWdlIGluIHRoZSBQTUQtcGFnZS1zdHJ1Y3QuIFsgSSBh
bHNvIGltcGxlbWVudGVkIHRoZSAyLWFkamFjZW50DQpwYWdlcyBhcHByb2FjaCBidXQgdGhpcyBj
b2RlIGlzIGxvbmcgZ29uZS4gXQ0KDQpNeSByYXRpb25hbGUgd2FzIHRoYXQ6DQoNCjEuIEl0IGRv
ZXMgbm90IGJvdW5kIHlvdSB0byBoYXZlIHRoZSBzYW1lIHNpemUgZm9yIFBURSBhbmQg4oCcZXh0
cmEtUFRF4oCdDQoyLiBUaGUgUE1ELXBhZ2Ugc3RydWN0IGlzIGFueWhvdyBob3QgKHNpbmNlIHlv
dSBhY3F1aXJlZCB0aGUgUFRMKQ0KMy4gQWxsb2NhdGluZyDigJxleHRyYS1QVEXigJ0gZHluYW1p
Y2FsbHkgZG9lcyBub3QgcmVxdWlyZSB0byByZXdpcmUgdGhlDQogICBwYWdlLXRhYmxlcywgd2hp
Y2ggcmVxdWlyZXMgYSBUTEIgZmx1c2guDQoNCkkgdGhpbmsgdGhlcmUgaXMgYSBwbGFjZSB0byBo
b2xkIGEgcG9pbnRlciBpbiB0aGUgUE1ELXBhZ2Utc3RydWN0DQooX3B0X3BhZF8xLCB3ZSBqdXN0
IG5lZWQgdG8ga2VlcCB0aGUgbG93ZXN0IGJpdCBjbGVhciBzbyB0aGUga2VybmVsDQp3b27igJl0
IG1pc3Rha2VuIGl0IHRvIGJlIGEgY29tcG91bmQgcGFnZSkuDQoNCkkgc3RpbGwgZG9u4oCZdCBr
bm93IHdoYXQgZXhhY3RseSB5b3UgaGF2ZSBpbiBtaW5kIGZvciBtYWtpbmcgdXNlDQpvdXQgb2Yg
aXQgZm9yIHRoZSBDT1cgaXNzdWUuIEtlZXBpbmcgYSBwaW4tY291bnQgKHdoaWNoIHJlcXVpcmVz
DQppbnRlcm5hbCBBUEkgY2hhbmdlcyBmb3IgdW5waW5fdXNlcl9wYWdlKCkgYW5kIGZyaWVuZHM/
KSBvciBoYXZpbmcNCuKAnHdhcyBldmVyIHBpbm5lZOKAnSBzdGlja3kgYml0PyBBbmQgdGhlbiBj
aGFuZ2luZw0KcGFnZV9uZWVkc19jb3dfZm9yX2RtYSgpIHRvIGxvb2sgYXQgdGhlIFBURSBzbyBj
b3B5X3ByZXNlbnRfcHRlKCkNCndvdWxkIGJyZWFrIHRoZSBDT1cgZWFnZXJseT8NCg0KQW55aG93
LCBJIGNhbiBjbGVhbiBpdCB1cCBhbmQgc2VuZCAoYWx0aG91Z2ggaXQgaXMgcmF0aGVyIHNpbXBs
ZQ0KYW5kIEkgaWdub3JlZCBtYW55IHRoaW5nLCBzdWNoIGFzIFRIUCwgcmVtYXAsIGV0YyksIGJ1
dCBJIGFtIG5vdA0Kc3VyZSBJIGhhdmUgdGhlIHRpbWUgbm93IHRvIGZ1bGx5IGFkZHJlc3MgdGhl
IENPVyBwcm9ibGVtLiBJIHdpbGwNCndhaXQgZm9yIE1vbmRheSBmb3IgRGF2aWTigJlzIHJlc3Bv
bnNlLg0KDQo=
