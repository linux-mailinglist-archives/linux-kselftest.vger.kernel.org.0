Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8002F4798AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Dec 2021 05:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhLREwS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 23:52:18 -0500
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com ([104.47.58.174]:21135
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230053AbhLREwR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 23:52:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfoJRvvwHzhnRMtwqon2gSXYyWC62SBUcvMOysG4D7w12USUdcfHhvTQaeo80XxKSDeQ+ayzAGftKX1DGBtsCJDX/vhIY774ORXSw7EgQDcXs8pVhUqd72XIaytDVr043hXoOzXqOjCj9OfKBag9/KYIwHuiLm0UcOm/qsCmtOAh4rTPKUkOUNtQc5cxeg5PctGweLC6H+0hc4sMRvR8TFagyG+hI4a2oo95tXuNqWP6TzqFfU8tk6yu6k9qsH0Pd6Pr7AkYKtLmLLFVbs42Ioe4MMcjwDbG00DzElfFDuAo8pnkMTa0ePSoJOZhkirKeUXXs/lEn4ztLqh6NJ+pPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EztsMO6Fv5+jkcyY8PskN3GuQGUHMUGuTwLY3VCaVM=;
 b=ePpKzhE+q1YCqAP8qWA0ym/U9B8D9lOrGBWBmuSw1/7JUUT9lOAGIymqUFwrLM75GTWhkSj2D169sHwPXctHY80wJHv6T4mhYTHhgcey6S6TJLlkZTh+skirEBBDqGw10BkoqJTUBxrIErRlEf0SXFh9lLBEegWF02mfMp/KW243Gq+TWi7OMF2PVNaMtvD2a9lM1J1dvFbBB4LpRHTOUwCnkPURsWAUh6tt7jrg2sAkx/6P5oHwc0zv3ixCW2vFD1TCsKLsJjpKDd78SueR0JTJArnZcAz9t7Qyn2TQVDliwizA99sPIErRocDais1WuWv3kCfvx4mmjInzARD//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EztsMO6Fv5+jkcyY8PskN3GuQGUHMUGuTwLY3VCaVM=;
 b=nIUy+bFIP8ix7uK8gw5baCm3ATAhhJXBFLeJn5h27cZFoYzFQO4f/hpDGzlQSIB08dNG+CDkI4JSjV4JVAn6VB+5iQ/gzld1ct4ietzeNKYm4j2dzqPSCCVBiYnhlByWGyBES+gi24oRHoz4B80uXNBG98cVxtQ3xCBGV2qSAcM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MWHPR05MB3600.namprd05.prod.outlook.com (2603:10b6:301:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8; Sat, 18 Dec
 2021 04:52:13 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Sat, 18 Dec 2021
 04:52:13 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
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
Thread-Index: AQHX8zoAtPq2ZaVmhkCLrf0rndre56w3C3aAgAAcDwCAAAMBAYAAC2GAgAAC+gCAAADIAIAACxEAgAAIKACAAAiogIAABosAgABFugCAAA3HAA==
Date:   Sat, 18 Dec 2021 04:52:13 +0000
Message-ID: <D54E059F-9757-46DB-919C-A31A067276CB@vmware.com>
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
 <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
 <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
In-Reply-To: <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2168bb4-17d3-485f-35bd-08d9c1e22858
x-ms-traffictypediagnostic: MWHPR05MB3600:EE_
x-microsoft-antispam-prvs: <MWHPR05MB36007A54EA1F2BC6EAFE8A62D0799@MWHPR05MB3600.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZlCGRNd0wrx86ejldCyTOjHnr3CyPGzcEl2evVVYUESiFroIW0GtYFHjLqiNg7fglUwxZbSaSddVvbzdCFTg/qXUB1ttw9FG8sCcdiu7hnTLPx8X8kw7rJPbvRS9NB4QNx+JSaHj0Pk7IliLlDL/V3PjuoO3YU12qmu8sBHslHab1R4eqjT4IbGBgFOR8tlaW/1jrde8s0wLg22fB/5IWiohQ3P1U4b0baOBsfFrSMYRbpisvVQVaPW7L88+axZp1sks2ramOloSG8tQ2lAvRL2W8yuPakimzvBoQ9XfSpX7D5itqezoABmD/dl8Qdpep5nkalBaqqWED6Wf8MIoKx8ZNf7zXVkMo1Q+Cp6IGyYnCr3bevHFdGFfZ39hnWSZuqbATmp25OCwEv1/T93LzQBQWo7vJw7ZtxCp8s9Ziye2VKYf7pOHa2KdMm1Y0r7ioBcGkBfrC8rgmtc5Tuk0eZelFs64m7TxnGE5BbrHXCqRh8OdDFDThJaudlXO1Ath01nc1zAxP0+N8uavwKp5KZSN7gfztB9oVlBaCXqYmqnQslhmPywr7cBGlsgesdqdYyju05eLdpE3nbP+nhircS8MdZbjELhYfZKFCpMmtE6SM/fM4/LeXMJnjTI7JvI60A00TfHC89MCOxYcC5EXJ03eflJpIceCL3DkS4hq2EcYM5o2E595FLXQutJfMEE5Arf+/0ZSsleHt7gE3Acc9zgaI+WS0cKz9NwDrX88c+j/6uPan+YO/LHWeJlTTOCyzMD9rYqYei45VOEnUJkkrUe/Cm4JiIKZ+NpYnGu/bV3YpbOBho+Qu0wetRgW3XEVL3CBQqvYsXjStq6yP65ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(83380400001)(5660300002)(64756008)(6512007)(186003)(53546011)(38070700005)(6506007)(36756003)(2906002)(26005)(6486002)(33656002)(122000001)(54906003)(2616005)(4326008)(38100700002)(66556008)(76116006)(66946007)(71200400001)(66476007)(6916009)(966005)(66446008)(508600001)(8936002)(8676002)(86362001)(316002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THVydWx2R21GU0x2eVJYY24vdXhkWWVRZ0RFT2NoTlh2YitHN3JZYzBTVnhY?=
 =?utf-8?B?L3FJTXgxNGdnMlUzeUxiT2ErdjlQdXk5QitzTURZTWQ0Vkt6R21ZOXFsdGdy?=
 =?utf-8?B?L25DQWNkMFQzVGQzQTFlNUlmWk1BZjFUeVh5Ly93RnhLd054Ylc2U2t0UktS?=
 =?utf-8?B?NzhvTzVObzZmbWlVTzVqVUZNMlg1WVRyZ2czRUhTbDBYd3hEOVhTdGxXOXg4?=
 =?utf-8?B?N0t4eTFGYVIzcWtjdUdmSE1kSmRvcjY2STRLSHp0eEpwNmwvcE9uTndsQjZ4?=
 =?utf-8?B?KzRHaGtkT01IRDRMZko5cUJDWVZGTDVlZVVpTk5IcU1UeGZ5RmUvV1lNWXVR?=
 =?utf-8?B?TGM1TjhlcjY5Unl5RmM0UnQ4dWNxMU16TjFCa2dzTzF3NnRyWXRUK1BlWFJa?=
 =?utf-8?B?aEN1Z2dmNlJWSkF1UnBGRW1xdTJzUXZxWVFhUkt0a3dhTkdzNHlXakxaY2Nn?=
 =?utf-8?B?MjdVdXNGc2hUd3ZkN04wQzltc1cxWnI5amJ3MGJJRXZ2ZTdpbCtuUER2dWRr?=
 =?utf-8?B?bjBUTnQyNkNtZ1hnZTd6ZHdrbitiR2J3U2IxZExSL1MzaXpteUhDWC9saHNn?=
 =?utf-8?B?MU4yTXlHY1o0L3RkZk5OQm9ZdHJSSDZ2ZjZ4MGhpOUY1a3Q1aUJybUdSelE5?=
 =?utf-8?B?YWFnZzJ0MmpsR1hBemMyYUd2VHVrUlpkZ1p0QitLZEpPZHR3dExqQlJEOUV2?=
 =?utf-8?B?SldiWkxtRkhlVFpXcDZCcE9TT05BQmdaT0E3anhRZEc5WlBXUmdRT2h5TnNS?=
 =?utf-8?B?Wk9EcFZ3eHRUeFBVd2NVdjVnT0I4T1BMU0hNbk9NWDV0MWhoNmIvS2J4K0g3?=
 =?utf-8?B?WFVscVp5ZTBnZE5jR1Jnc210bXJiOTdGTHA0cldZVzBXdEZBK1FxejVQZ3E0?=
 =?utf-8?B?UHcyd2Z5dkh3bU9UT0UvMXBleWhKSGJTSlpmNVloZTZoeFlEWHFHemZJSlJH?=
 =?utf-8?B?aDI0aWhSSHIwUTh6OG5ZS3cvTDRIVnRkQ3ZzV1NqUEZWaVE3c1Z4TmFNN0Q5?=
 =?utf-8?B?Z1lTUDVFYjV4K0NZNnM2SVc0YUptWEcvVGxBVUxZWjNyRi9tb0VsbitrdU5G?=
 =?utf-8?B?ODhqb2l3aUVNOHRSOStZek5DTUdsWnZlY05YemE2b2VaSTR6UWVSdGRaMHhG?=
 =?utf-8?B?SElHclhoZjhCRG5WZWc3WWFvdTYvdGw1RGM1ek93VXhxS2lvZFJZVGNxU3Bj?=
 =?utf-8?B?MjAvaWxreTh0d1RKODE1WGpnTnJGZk5jeVNWbXpDWEltd0h0a2w4WTlNTXVz?=
 =?utf-8?B?Rjl4WVZFWUFKSGd5M2VjQXJNdThVcDdERWt3RUNhK1lEc1Zpb3p6NG9Ec2Fo?=
 =?utf-8?B?aWxiRXQ2V3NYRUNKRTRSbXV2RWw4S1lhc2ZnOWo5U2Q5MHVqOS9BSUxXMjM0?=
 =?utf-8?B?Y0FRTmd2QU1aWWV1UElRUkhURlhHdkVPcHp1SG9GaWY4dlNkRklVcjF0UVJW?=
 =?utf-8?B?UjJudHdzeDFtMnFNc0gxcnhKdDNjWEZGMVU3M0R6OTNLb2NWNWo5OGN0amto?=
 =?utf-8?B?N2trRW5BMjlwMUdvSWZORENoNWYwekZ2VzQ0b2lvWXZNTXZxMlhDVWV5blRq?=
 =?utf-8?B?RU93cldUem5wMWRmcWhxSFBCRWdkQ3JBT1orZ3JaOXc2cFZMTXh3RDN0dWRY?=
 =?utf-8?B?VXlOZ25zQzMyUktSZkpqd0lybm9rcTVkV0F3RHBBOXRiOHpEc3d4MTVsb0pW?=
 =?utf-8?B?ekUrcDltOHJDVnk0bXk3WlJxSEZ2bGRpZnhXUVVaL2QxazI2QktNTUJndFVX?=
 =?utf-8?B?SWZkMXd5cTRSZ2JHVkM0b2RlNjVaVG1xbkhnRmROZGNBZHJPWGJSd1BubHlk?=
 =?utf-8?B?eVN0SkhoSDYwbFJRVmZNeHRaVTRSUTJkNmNCVnJzM0xZQjZaSTRrV2EvdTY4?=
 =?utf-8?B?M3pYdDdYV1Z4U0R1NGFabUVtTlozTWZkUGRod0dKTE9zeDNzT1dXNHo0S1lT?=
 =?utf-8?B?K1B5RE1CNHBkd1N3L1JhVFpzKytxOGlFbGEvOXFKQ3RVU2pqeS9WeWQ5Y1hM?=
 =?utf-8?B?QzZzbXFSZGtFNlNnVzR4WnQ0N2pjc2pMenlscitKdGlQVUFna3BGS3E5dU03?=
 =?utf-8?B?b2QzR1pnMlJUOG9pc3JXNzdjL0lOMXpDT0RoejI3R0NtZzFCOWIxc0J1Nkhx?=
 =?utf-8?B?U1prSWxwd3hlaVdyVkFnZnZUNURlYmlwRU1NZkVQWXEzeU1qZDlhWDh3d1Ay?=
 =?utf-8?Q?T9XBRcPk1YWVwIyr8CL0E0Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC3D92BC0E72264A98056B7FA5547F32@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2168bb4-17d3-485f-35bd-08d9c1e22858
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 04:52:13.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INuR14VQ0UVFhjblDROhBiIRLP0Re7gdodzHmwm4LyLraO7oiSLpAju8JQ7YQjI95j0AHhOyqQkEyLfYCcSgOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3600
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IE9uIERlYyAxNywgMjAyMSwgYXQgODowMiBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgRGVjIDE3LCAyMDIx
IGF0IDM6NTMgUE0gTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+PiANCj4+
IEkgdW5kZXJzdGFuZCB0aGUgZGlzY3Vzc2lvbiBtYWlubHkgcmV2b2x2ZXMgY29ycmVjdG5lc3Ms
IHdoaWNoIGlzDQo+PiBvYnZpb3VzbHkgdGhlIG1vc3QgaW1wb3J0YW50IHByb3BlcnR5LCBidXQg
SSB3b3VsZCBsaWtlIHRvIG1lbnRpb24NCj4+IHRoYXQgaGF2aW5nIHRyYW5zaWVudCBnZXRfcGFn
ZSgpIGNhbGxzIGNhdXNpbmcgdW5uZWNlc3NhcnkgQ09XcyBjYW4NCj4+IGNhdXNlIGhhcmQtdG8t
YW5hbHl6ZSBhbmQgaGFyZC10by1hdm9pZCBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbi4NCj4gDQo+
IE5vdGUgdGhhdCB0aGUgQ09XIGl0c2VsZiBpcyBwcmV0dHkgY2hlYXAuIFllcywgdGhlcmUncyB0
aGUgcGFnZQ0KPiBhbGxvY2F0aW9uIGFuZCBjb3B5LCBidXQgaXQncyBtb3N0bHkgYSBsb2NhbCB0
aGluZy4NCg0KSSBkb27igJl0IGtub3cgYWJvdXQgdGhlIHBhZ2UtbG9jayBvdmVyaGVhZCwgYnV0
IEkgdW5kZXJzdGFuZCB5b3VyIGFyZ3VtZW50Lg0KDQpIYXZpbmcgc2FpZCB0aGF0LCBJIGRvIGtu
b3cgYSBiaXQgYWJvdXQgVExCIGZsdXNoZXMsIHdoaWNoIHlvdSBkaWQgbm90DQptZW50aW9uIGFz
IG92ZXJoZWFkcyBvZiBDT1cuIFN1Y2ggZmx1c2hlcyBjYW4gYmUgcXVpdGUgZXhwZW5zaXZlIG9u
DQptdWx0aXRocmVhZGVkIHdvcmtsb2FkcyAoc3BlY2lmaWNhbGx5IG9uIFZNcywgYnV0IGxldHMg
cHV0IHRob3NlIGFzaWRlKS4NCg0KVGFrZSBmb3IgaW5zdGFuY2UgbWVtY2FjaGVkIGFuZCBhc3N1
bWUgeW91IG92ZXJjb21taXQgbWVtb3J5IHdpdGggYSB2ZXJ5IGZhc3QNCnN3YXAgKGUuZy4sIHBt
ZW0sIHpyYW0sIHBlcmhhcHMgZXZlbiBzbG93ZXIpLiBOb3csIGl0IHR1cm5zIG91dCBtZW1jYWNo
ZWQNCm9mdGVuIGFjY2Vzc2VzIGEgcGFnZSBmaXJzdCBmb3IgcmVhZCBhbmQgc2hvcnRseSBhZnRl
ciBmb3Igd3JpdGUuIEkNCmVuY291bnRlcmVkLCBpbiBhIHNpbWlsYXIgc2NlbmFyaW8sIHRoYXQg
dGhlIHBhZ2UgcmVmZXJlbmNlIHRoYXQNCmxydV9jYWNoZV9hZGQoKSB0YWtlcyBkdXJpbmcgdGhl
IGZpcnN0IGZhdWx0aW4gZXZlbnQgKGZvciByZWFkKSwgY2F1c2VzIGEgQ09XDQpvbiBhIHdyaXRl
IHBhZ2UtZmF1bHQgdGhhdCBoYXBwZW5zIHNob3J0bHkgYWZ0ZXIgWzFdLiBTbyBvbiBtZW1jYWNo
ZWQgSQ0KYXNzdW1lIHRoaXMgd291bGQgYWxzbyB0cmlnZ2VyIGZyZXF1ZW50IHVubmVjZXNzYXJ5
IENPV3MuDQoNCkJlc2lkZXMgcGFnZSBhbGxvY2F0aW9uIGFuZCBjb3B5LCBDT1cgd291bGQgdGhl
biByZXF1aXJlIGEgVExCIGZsdXNoLCB3aGljaCwNCndoZW4gcGVyZm9ybWVkIGxvY2FsbHksIG1p
Z2h0IG5vdCBiZSB0b28gYmFkICh+MjAwIGN5Y2xlcykuIEJ1dCBpZiBtZW1jYWNoZWQNCmhhcyBt
YW55IHRocmVhZHMsIGFzIGl0IHVzdWFsbHkgZG9lcywgdGhlbiB5b3UgbmVlZCBhIFRMQiBzaG9v
dGRvd24gYW5kIHRoaXMNCm9uZSBjYW4gYmUgZXhwZW5zaXZlIChtaWNyb3NlY29uZHMpLiBJZiB5
b3Ugc3RhcnQgZ2V0dGluZyBhIFRMQiBzaG9vdGRvd24NCnN0b3JtLCB5b3UgbWF5IGF2b2lkIHNv
bWUgSVBJcyBzaW5jZSB5b3Ugc2VlIHRoYXQgb3RoZXIgQ1BVcyBhbHJlYWR5IHF1ZXVlZA0KSVBJ
cyBmb3IgdGhlIHRhcmdldCBDUFUuIEJ1dCB0aGVuIHRoZSBrZXJuZWwgd291bGQgZmx1c2ggdGhl
IGVudGlyZSBUTEIgb24NCnRoZSB0aGUgdGFyZ2V0IENQVSwgYXMgaXQgcmVhbGl6ZXMgdGhhdCBt
dWx0aXBsZSBUTEIgZmx1c2hlcyB3ZXJlIHF1ZXVlZCwNCmFuZCBhcyBpdCBhc3N1bWVzIHRoYXQg
YSBmdWxsIFRMQiBmbHVzaCB3b3VsZCBiZSBjaGVhcGVyLg0KDQpbIEkgY2FuIHRyeSB0byBydW4g
YSBiZW5jaG1hcmsgZHVyaW5nIHRoZSB3ZWVrZW5kIHRvIG1lYXN1cmUgdGhlIGltcGFjdCwgYXMg
SQ0KICBkaWQgbm90IHJlYWxseSBtZWFzdXJlIHRoZSBpbXBhY3Qgb24gbWVtY2FjaGVkIGJlZm9y
ZS9hZnRlciA1LjguIF0NCg0KU28gSSBhbSBpbiBubyBwb3NpdGlvbiB0byBwcmlvcml0aXplIG9u
ZSBvdmVyaGVhZCBvdmVyIHRoZSBvdGhlciwgYnV0IEkgZG8NCm5vdCB0aGluayB0aGF0IENPVyBj
YW4gYmUgY2hhcmFjdGVyaXplZCBhcyBtb3N0bHktbG9jYWwgYW5kIGNoZWFwIGluIHRoZQ0KY2Fz
ZSBvZiBtdWx0aXRocmVhZGVkIHdvcmtsb2Fkcy4NCg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbW0vMDQ4MEQ2OTItRDlCMi00MjlBLTlBODgtOUJCQTEzMzFBQzNBQGdtYWls
LmNvbS8=
