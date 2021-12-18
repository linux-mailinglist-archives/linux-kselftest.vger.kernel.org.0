Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA5479DA3
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhLRVtK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Dec 2021 16:49:10 -0500
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com ([104.47.58.171]:18135
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231545AbhLRVtD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Dec 2021 16:49:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aisJzECP0zco9bMXMqzwlUOZBv+sYLbtcRNbIbNVrcgJoOkp7j6dlxtba+pVUo1UEPO1FNx/oPsigXR5QaA0WnBPgCTMsgUQbyVygj9Tb6BfJhjqmsrIwLpkzN+3/sWF6u2wwcP6shl+vwoL40QX5lVcqXt2qPQTqiy6KF1psnqBAd5ArKSJw1toD1U7frQg4lL8bBRumSr1F0Yljnv/u4D9iJCrwz2BnISj4lUCLhgKB32V6LR0O5CDVHj/4s+gtXpJDZKDO04WiLqnURCOd5Ns7mX8JmNshPKrFws+Xm/d9Ulur9m0Feqcr6iR74YiV+G6D3sFq3K6+znO7AavJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIai4/V/zJYAl6FdO5mxpVybrB530IzKWWG6nZWmWwA=;
 b=IDBAN4Fu5GrtlmlIwgDVtncJRKsgRt6aOfdHB8MsbQ+tiLp/vN+cWF6Y0148e5Zyw+Abg94/QkX5Z459BXdyed3Gtvdanld/HkjqtOvmaOdjDw9LKLN45T8d3DyTNkN5EM7/Vol1IxXUfgCgu9JxBAyqRD2ZY9AgW3qd4bV34YWLbZCfmpwM17gUnCPdHcwOCegEDiXXCQaudTc59hIg9OI+UXzVxtsR5t+iRAFe2j31OaAckLpl9YwB5XVYKlvKABqE7PqivrNf/MwEnB5qM7RRLpvXNCaIZ0hwFcVNPULg0kH3wvRknqGOtMLzDnasdEJZNKniynV53gGfLxCg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIai4/V/zJYAl6FdO5mxpVybrB530IzKWWG6nZWmWwA=;
 b=JOiFbuBSlnOfa6c9J9Y4E4PPuP34s07oRVM5m7tlCIdqZRAMePoTLhZlT2/ZjTAEI1NPsMRFeiQhcDp0PZp0g65zUfqiA/As27bGC9q5Ltol9KUHV6XJ1osPj+5RQFHg9lboFx1SZTgZfkrD5Dndv1t+sHuOi7jrWY1hvN0m74I=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB4073.namprd05.prod.outlook.com (2603:10b6:5:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.7; Sat, 18 Dec
 2021 21:48:59 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.013; Sat, 18 Dec 2021
 21:48:59 +0000
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
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAFCICAAA9rAIAABT2AgAAC5YCAAAgCAIAATa2AgAAT84CAAAcTAIAAAkmAgAD8jICAADQXgA==
Date:   Sat, 18 Dec 2021 21:48:59 +0000
Message-ID: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
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
In-Reply-To: <20211218184233.GB1432915@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95b55ccf-1548-47fd-a42e-08d9c270331b
x-ms-traffictypediagnostic: DM6PR05MB4073:EE_
x-microsoft-antispam-prvs: <DM6PR05MB40737396696718378D700655D0799@DM6PR05MB4073.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: elLH+f8+9oJSlrOfS73QO0xtShZwb2BdTOu8B4c2GevdhbseZ9P6x4dYoLBStPdNvQ1LQSBRSeSsRQz4hPAI0zMnnJtFMKBGvDU0khIOODPyrarVpPJo1kBrcnPQ854v9IgNhxSb3NhZSW+7u9PcQ7FZWRUcTiiliUARqEgwffWXPXM8nIlWpgcqhqE5EmtKdU2dArIzxHrTu7b9xBD9NLe0rtFx88Eem56T9MSI8qq3YM4AGxRmZvu8cKCC1q4DOWQcccEMMOJmT8GsAmbPD7kpLNC2UosCc19b0jd/tfyuDk/aECTc8J+eghoOkFOi6q9WjES0V51nnzfDy7L/pHUW1ug4rxYlwJIys/3aoKSXLozR+JUQuWNEJhkNUjImmX6qTCfyF21omyu8Ed2kh8PIFfevQOEZoHv7w1PBKyCai9Tgbd6eU5zR45uldhhFdU3qVF9SuMD3qlaqtMQ7XHDowZEBHhcuGerRqa+6jQDOQUCDh0le81uS0AuIFNpfyrImTpMUW17qtuL7FMG3q1ydMNiTE6mw2T3TxH2UnlWOZiKl/RzcXewci292YTNfC6qp3Dybctkx9+eh8aNbECPzEj2no1v7Y7R9Pnk61n67X6X20SoAwmvqsAIw+dBHuNNFc/4GB5BTcDiBIY1E9WyBo57HznJONJOcd76Xr5JoKxFHU74svIsGw5PDKQNHcObgrnf/QurV96tz5/UIY4VZIDzFqMA79Zv1Iuza6ZiQWckO9ZanVGrzUuwR/mUL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(7416002)(6512007)(66556008)(66476007)(38100700002)(4326008)(6506007)(53546011)(122000001)(6486002)(54906003)(6916009)(5660300002)(66946007)(76116006)(316002)(66446008)(8676002)(86362001)(64756008)(71200400001)(8936002)(38070700005)(36756003)(186003)(33656002)(26005)(2616005)(2906002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Lzc0cmoxeXJzZ2lQeEdtdTlMSTQ2bGhENmJUdUpxZ2FhMFRuRVF3NHhzVlM0?=
 =?utf-8?B?T04wS3oybmhjN0w3bmsrMytySXd5UzdHdWZ3SGFydHZQNE94c1ZSRVI4M3BI?=
 =?utf-8?B?UzJWaVIzeElTclFISGQ3UkwrcjYvamlxaDRKcjd5aVQ5RXlTOXZLeFVkRmFl?=
 =?utf-8?B?eFBCVWlTMm5mS2doZlRSUUkxYjAyaHVWbjVrcEhvcTNPc1p4V21seGFKVTJt?=
 =?utf-8?B?djVGWXBFYzlIaTU4TW5TN3FSYnpDYWR5a1BWN01Ydm9ZVUZmMzluWWJYUGhO?=
 =?utf-8?B?bnJIZXpvMmtXbURnQjkraUV4MzUzUU5aRWRTbHhjZWhKZkNJbFRKWi9vT3pK?=
 =?utf-8?B?QXB0eUxSTDNQam5HZHJlRjdMZm9aU3JyR2RMd09iemEvcVNOaFZaMnhvcDBl?=
 =?utf-8?B?WlRkUE5LUU9uQklxNGU3VVhuMTBjU3B2RkdGZmZaU3d5UFV3c1JaZU54Mm50?=
 =?utf-8?B?anEwU1k5VkZwNEgrVjljMEFZeFRYV25CVEZhV21UcmhLRXMreStwL3FPeVht?=
 =?utf-8?B?VnlNNjRkSmNlMWtId291WitCQ0RGMEZmaVN6akdnZkdqVHFvVEVVaWFVcW0w?=
 =?utf-8?B?aDdrRnRnajJnWDJ2QmZKSW9GaWxWeWpoRWNON2lxU2FDMDhsRSt3VENhdU1O?=
 =?utf-8?B?eHV2NGVYT0FRczZBc2FtWWdtYWhkdnJVaGw2dUVVd2ZLekprQXVOd2tYMGRJ?=
 =?utf-8?B?SElab1NzQ1JUSytWVFlKTEVvK3VZbUF1Mm5mUXBVSUdLVG8vNFF5MmdveGV4?=
 =?utf-8?B?MTloeVJ4TlBvbmRVZ0FSd2drRDBaWUl2TWhUMld3eWQyYkdxdnMxOTJGSlJR?=
 =?utf-8?B?K2xlM29IVUw3SUxGdWhUdVozYVRWdk9lekM2bkUrdmErbTIzVmFVVW9qSmlW?=
 =?utf-8?B?VXAzR1VkYlcxK3ZMaFZrTkZBeW9zbWg2dXhoR3JmbTZQTEllN1NzR1hWYUx3?=
 =?utf-8?B?b2MzelZSSWp6OFQxTzFqdEV0c2s0djBWeS96QnRtOVA3SDRlUjhTUmRDbTdu?=
 =?utf-8?B?NG1tWEJtQndYQlBKamxNRWticWpBUHNvb3FCYjFHVHN3aFFBS2Mwdmt4T0ZJ?=
 =?utf-8?B?OUdzZFFPRFpYai9xL2pRZllDWEtIZlh5cXVlME5mY3psSDRVVVZLL1dPZ3Iz?=
 =?utf-8?B?MFhrb3JTekQ2bk9kQ2tQYlUyVmJHdWFNNkFuaGR4TUFkT2w4RWFaMXpYcVFN?=
 =?utf-8?B?aS83Z2ZNRTRBT0c1cXhtdGJJWUU1WTFEN1QrVGs1MDdWVTB0UXlxRU5PQ2tW?=
 =?utf-8?B?Y2NQS2l0MU8vQks0Wjl6T2t1d2dMWFoxTzIwYm9VQnN5NEVtdldQOFR2ODhY?=
 =?utf-8?B?a2pFSHNHN3hrVktyM1F3RTRpNmxjL0RoNUJzaVFmYVZUUmtseHdMbW9sRFlR?=
 =?utf-8?B?ZmdORExqMUQ4ZE1tdmRQQTZ6akxRcWUzaEJQd1hLcG5uUG10L0s2OFpWeHov?=
 =?utf-8?B?NEJ3cnZERW8zYWxWTGVZd1JBV1dhSHl6OTlrdnhLRjJic1ljTTJxL2tOOCtR?=
 =?utf-8?B?dzVtbDBjQ0N0S1A2QkdUcG1Hajc2V1hNNFZxWHBDL3R6RTJVOEk2WW83bkli?=
 =?utf-8?B?U1ZPOVRCM0c5MlRVb29YWnBvWlRyeWdkb2pGUkQ4ZHNSeDB2MFZvQnVGOHcv?=
 =?utf-8?B?Ty9FbnVDZVoxWmUvdW9sTnRoRlJ6Vm9yRk1VWXpOZnhIL0l2MWd3WXhPVjNL?=
 =?utf-8?B?c1dzK2pDR0dGQURlMGQzeG1vTGdxZ1FRTCtOZWYvZ2tSK3E4REMveUFodzVM?=
 =?utf-8?B?SklsVHB0Vy9La1BIaVNLZmVKUXBNYTl1WXN6RkpZaFBrc2ZSUWtXeW5uN1lI?=
 =?utf-8?B?M0NReUU5TmpSaGNKOGhKWkN6VUFZWktTVW0ycmhiYU9kbml1REhjLzk3cGlU?=
 =?utf-8?B?clMvREZINXZ1WmMvZG8wT1VyZEFtejlWTkp6ZEJoL1FTcmdVWWk1dXhKUWRj?=
 =?utf-8?B?ZENSbUZZZ3lCZXo5LzExNXU1QnhUcDNPa1FSaERtMTAyYk9Db05XSHRDZmFz?=
 =?utf-8?B?SUFPL3Fsa2FveUYrQTBOTndneStqTlJKSldKTEJoNXlzcUkycWV2N3VMeXEv?=
 =?utf-8?B?Ym1qL3hzTjZRK05SVUhRZW8xQXBPdldpWEhrWjVEOTJiNlhXZ2lZNXpKV3da?=
 =?utf-8?B?N2labUtBSEM5dDlMaFdvQXQ2ekduNjhQc0VyYWYyU05PcTJVVnVnRDQ2NVBX?=
 =?utf-8?Q?vz+3PTw7NAofNLypzaVQ74Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37EAF997986D8F4B84D3A1089D82E78D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b55ccf-1548-47fd-a42e-08d9c270331b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 21:48:59.7336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oF92iBiy2RTjHE5pSJtLkKMcbGzijUs+2J4LiJTj7LgIVJdz0xFLKsSluTgB8+S7AcXfwA1LESyMk6kpUpSPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4073
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gT24gRGVjIDE4LCAyMDIxLCBhdCAxMDo0MiBBTSwgSmFzb24gR3VudGhvcnBlIDxqZ2dA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIERlYyAxNywgMjAyMSBhdCAwNzozODoz
OVBNIC0wODAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4+IE9uIEZyaSwgRGVjIDE3LCAyMDIx
IGF0IDc6MzAgUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+
Pj4gSW4gc3VjaCBhIGNhc2UsIEkgZG8gdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gZmFpbCB1ZmZk
LXdwICh3aGVuDQo+Pj4gcGFnZV9jb3VudCgpID4gMSksIGFuZCBpbiBhIHByb3RvdHlwZSBJIGFt
IHdvcmtpbmcgb24gSSBkbyBzb21ldGhpbmcNCj4+PiBsaWtlIHRoYXQuDQo+PiANCj4+IEFjay4g
SWYgdWRkZi13cCBmaW5kcyBhIHBhZ2UgdGhhdCBpcyBwaW5uZWQsIGp1c3Qgc2tpcCBpdCBhcyBu
b3QNCj4+IHdyaXRlLXByb3RlY3RhYmxlLg0KPj4gDQo+PiBCZWNhdXNlIHNvbWUgb2YgdGhlIHBp
bm5lcnMgbWlnaHQgYmUgd3JpdGluZyB0byBpdCwgb2YgY291cnNlIC0ganVzdA0KPj4gbm90IHRo
cm91Z2ggdGhlIHBhZ2UgdGFibGVzLg0KPiANCj4gVGhhdCBkb2Vzbid0IGFkZHJlc3MgdGhlIHFl
bXUgdXNlIGNhc2UgdGhvdWdoLiBUaGUgUkRNQSBwaW4gaXMgdGhlDQo+ICdjb2hlcmVudCByL28g
cGluJyB3ZSBkaXNjdXNzZWQgYmVmb3JlLCB3aGljaCByZXF1aXJlcyB0aGF0IHRoZSBwYWdlcw0K
PiByZW1haW4gdW4td3JpdGUtcHJvdGVjdGVkIGFuZCB0aGUgSFcgRE1BIGlzIHJlYWQgb25seS4N
Cj4gDQo+IFRoZSBWRklPIHBpbiB3aWxsIGVuYWJsZSBkaXJ0eSBwYWdlIHRyYWNraW5nIGluIHRo
ZSBzeXN0ZW0gSU9NTVUgc28gaXQNCj4gZ2V0cyB0aGUgc2FtZSBlZmZlY3QgZnJvbSBxZW11J3Mg
cGVyc3BlY3RpdmUgYXMgdGhlIENQVSBXUCBpcyBkb2luZy4NCj4gDQo+IEluIHRoZXNlIG9wZXJh
dGlvbnMgZXZlcnkgc2luZ2xlIHBhZ2Ugb2YgdGhlIGd1ZXN0IHdpbGwgYmUgcGlubmVkLCBzbw0K
PiBza2lwIGl0IGp1c3QgbWVhbnMgdXNlcmZhdWx0IGZkIHdwIGRvZXNuJ3Qgd29yayBhdCBhbGwu
DQo+IA0KPiBRZW11IG5lZWRzIHNvbWUgc29sdXRpb24gdG8gYmUgYWJsZSB0byBkaXJ0eSB0cmFj
ayB0aGUgQ1BVIG1lbW9yeSBmb3INCj4gbWlncmF0aW9uLi4NCg0KTXkgYmFkLiBJIG1pc3VuZGVy
c3Rvb2QgdGhlIHNjZW5hcmlvLg0KDQpZZXMsIEkgZ3Vlc3MgdGhhdCB5b3UgcGluIHRoZSBwYWdl
cyBlYXJseSBmb3IgUkRNQSByZWdpc3RyYXRpb24sIHdoaWNoDQppcyBhbHNvIHNvbWV0aGluZyB5
b3UgbWF5IGRvIGZvciBJTy11cmluZyBidWZmZXJzLiBUaGlzIHdvdWxkIHJlbmRlcg0KdXNlcmZh
dWx0ZmQgdW51c2FibGUuDQoNCkkgZG8gbm90IHNlZSBob3cgaXQgY2FuIGJlIHNvbHZlZCB3aXRo
b3V0IGN1c3RvbSwgcG90ZW50aWFsbHkNCmNvbXBsaWNhdGVkIGxvZ2ljLCB3aGljaCB0aGUgcGFn
ZV9jb3VudCgpIGFwcHJvYWNoIHdhbnRzIHRvIGF2b2lkLg0KDQpUaGUgb25seSB0aGluZyBJIGNh
biB0aGluayBvZiBpcyByZXF1aXJpbmcgdGhlIHBpbm5lZCByZWdpb25zIHRvIGJlDQpmaXJzdCBt
YWR2aXNl4oCZZCB3aXRoIE1BRFZfRE9OVEZPUksgYW5kIG5vdCBDT1figJlpbmcgaW4gc3VjaCBj
YXNlLg0KQnV0IHRoaXMgd291bGQgYnJlYWsgZXhpc3RpbmcgY29kZSB0aG91Z2guDQoNCg==
