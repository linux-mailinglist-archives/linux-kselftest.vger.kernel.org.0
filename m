Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF8479298
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbhLQRQD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 12:16:03 -0500
Received: from mail-sn1anam02lp2040.outbound.protection.outlook.com ([104.47.57.40]:6458
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239419AbhLQRQC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 12:16:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOS180MjKI/E6uJ2y8X7ckqfgAeawUYZJ61w0YZORtq/n3YlN6Wd+iqk0L8bEAQthodmzPNTqpPKu+PuA3uM1fwfU62GZMw4M9w+aOTHNVmrMig2fS65CnViGmVMOIZHv9ns8c42U8de1fHEOVI5QGcGwpGVE37RIcsiVmf+L/i5TFHaq1p1r95uVPymEe/NIjC+VEOpwmz815KCstDLOzx41M6tislKIWcyMJtR7Klh6kIrH513Y1QHz7b4wKTKIWBP7V6N4+1LyF0GszAMwMZNcU3548Vk6Bde+Seg/K659U6rmKZ8jHizcbyMyYV/jc8IbIaZI2xCx+Vo65saCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCBV+JN/pJSwd+uZwX6WooY/ckJkXmvt3aYmFjKGyeI=;
 b=Eg6jC4+7MOa4PqPjDLfNBZ6kZmAJyRV/dKYqk8OXn9Zhpuw+RUArXQYncqKoK0DDflzhA82fg3JvjF3wV0y8bkntDWFwsTiav4U6/fpJG/ju1NYvHjchRc/kOd+cney29YWtemmWqGw1TZxS1+Cqu6SOnfHSVWeEyzbD2Q1fOURNhIA9qCQ2WQ5nU/aAy/zcw9NPTrNDnqR5BjGZrWJGi2VwwwEtZlHFzxXI1wSow0XbueRyR9TvvIOvTZUnLgi78Cym6K8GniqQ0iPJnKcsKUeA0qdYBceOXCHx+exN1oSLI+XTwDA5+dJTRr318oCAWfasSCfwBmEHgGsIvjp1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCBV+JN/pJSwd+uZwX6WooY/ckJkXmvt3aYmFjKGyeI=;
 b=t5OEyv9DqLz3/fegrNj5rGNmbm9XRe8YlNgN8wRWY/t9EM+nteYwxXVeZe5m3LBltdseKHpZKzeza8XthT6Lb5WSmhs1XbI0kvEGcqabq34mvkv92PRUBI8P+9xNvGbhwIeyhqyK71ZAzxFrjLgm1N0SvmYf30b1CBcBqbE4GTs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN7PR05MB7582.namprd05.prod.outlook.com (2603:10b6:806:f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7; Fri, 17 Dec
 2021 17:16:00 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f4f8:9fc8:59d9:3345%3]) with mapi id 15.20.4823.009; Fri, 17 Dec 2021
 17:16:00 +0000
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in
 __page_mapcount()
Thread-Topic: [PATCH v1 03/11] mm: simplify hugetlb and file-THP handling in
 __page_mapcount()
Thread-Index: AQHX8zn3v2IqnN3pZUarNh3bmsL556w27RCA
Date:   Fri, 17 Dec 2021 17:16:00 +0000
Message-ID: <10A6B16D-3570-4010-83B9-41A38B50C8A4@vmware.com>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-4-david@redhat.com>
In-Reply-To: <20211217113049.23850-4-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40cdcbd9-c3cc-42e0-7bdf-08d9c180e5b5
x-ms-traffictypediagnostic: SN7PR05MB7582:EE_
x-microsoft-antispam-prvs: <SN7PR05MB75828324737AA89A59BB89E5D0789@SN7PR05MB7582.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7v7rA1jkAFxF571e5+ehX9RMcwKBSmXYjxChI7xQlxi7t4lBdNNDwJPZ2EvVnAbYWBqdRP39FrcVgfTS0o+0vLRr3PRPk433GfKmgVf8fSg6qCBrC2MM9LtWhY1BNbWrDModDAjWRV7ueq4Z5+SuEvzppm9qBV2bfi3mJa/ZVEYffgThe4QssFysR2JajC9QV3+9P8oqCo7x1kn0rRpBX9l/FIcK5F1N62aG08Qt0uZo+QC0eXe6z/og+OlIeiG9VZQ0I01ffEP+flWhZvL7Ly3RUmE4P2S8HM1S67iwy2qZ/a0VSFcne8nMOGh2TMtateEs6kfxR47VM3wPw1IFoNE/nHOASFfEndN0vAS/G4fNvbao6GmLsDaxS6EpPgN/LmbKW40ZH4YjlS34AY+DtcTDMgTRXnYwjEoMEd032RmSXncCj87GYP8Fl8gKbvduUBLUJXRR/IoSUw/OzuJ1M4kVeBmkaIxPT1RtLbLG8pJF8uxvDIUgSi47Iv5yvvWhMlTRiSNCcxfVFanjRiaRnRB0/xsMi3kFGQ0pLXW8usiWQxVjFyMjJ47EE7K0JltqrBnH4a/aqBNKfdrcpMfcf0ewCj/6LD/a2tFqSBv/JhYZN13lRJefxKJmzdTJHqVoJYrs/Gj2/Po4Q7bxTYWzicRQpbjJszdztIYu8o1IbjZxCS9RbwaMfHEeN0W00pxsbKqkr7Ds5rn0k9kh/Gv2Behq+OHLtCSDa1nXivvDWFYRAGQcsJAjwnV/ydzgwPaNSfjsri+xur070nFvRuU5P+LiFAq6iEMv2wQLXvD/1y4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(2616005)(76116006)(508600001)(53546011)(316002)(66946007)(66556008)(83380400001)(38100700002)(86362001)(4326008)(64756008)(6916009)(54906003)(66476007)(66446008)(8936002)(8676002)(122000001)(26005)(186003)(6512007)(6486002)(6506007)(2906002)(36756003)(71200400001)(33656002)(7416002)(38070700005)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXFYUWFZYWZWVEVBT3B1bmlOeEFKeXNxYnNkVld2VFVjaDVqYkNRK3cyQkl4?=
 =?utf-8?B?MkJhQ2xNVmdRQUxsYkY2OThSWTZNUnA2Y2xCTWxIa3FIb29VTmF4d0IxMElU?=
 =?utf-8?B?UEJQR1BuZEVuVjJTTlR3b2o5dVdVTkQzbEx6QUNOb2laQTl5djVGbUxPdXBo?=
 =?utf-8?B?cnQ2WDlURXpIQmZQVWxqZlhZcjRPazg4bDhseFQzZEVJSjVlbDZ4SlRoSy8r?=
 =?utf-8?B?UnQ3TnkydkdUYkFRQXhTcFZFUkpueDZhOG0wNHU1TEVBaHlvckg2UFU3Z1d2?=
 =?utf-8?B?UjFVQS9raThYbDlpUUtsQnVLNEVicnh1RGRWYWtla3BVRjlEREU4cGZHVFU0?=
 =?utf-8?B?RGFHV0JrVC93VVZCaEZ1NWlJSldxajQyMGdlRkpHT3cxdWtOZGFib1pGOXNs?=
 =?utf-8?B?VmNhMVVXWnVRTkNkdEJ5ZHZpRVpVZHNObzh3V2l3dXhWMHZhR2FqWWIvRHBJ?=
 =?utf-8?B?MTJpbW0xcnlxNHUzMEI5WmpteGx4a3ZVbnl5WUlybG1FMkFTWm4rZWtEZnVU?=
 =?utf-8?B?d2kvdXVRWGd5dnlOa05TMHFnUkU2RW5Nalg5RWg3dithVThKNzRPRFZqUk03?=
 =?utf-8?B?N1dlaHhTM09LOE1vK1N5VlhreURaMDBHRTkzRTJKT0ltMkppNUkzZmxtNGs2?=
 =?utf-8?B?bUttZU9FS0JUZ0srejE2YjlSNGp5RjA2K3dKZGxCY3huUy9aaGxLT2J0cVlG?=
 =?utf-8?B?NEw0VXNPaWh4dkUyWkpBZ201aFNVSGFJYUk5Z1JsUXBRRGdBU1BWTEhZOHB4?=
 =?utf-8?B?T1pCNHBwWVp1ZlFaSnZJRFVLVTRPQUhKdHE0SngwUWdubWw4cGd1MUtaQnNF?=
 =?utf-8?B?ZWZkOGVKZFE2dUJwYWxJRGxwMkxMVVc0dXNNNmJPTzluY3g5bFRHNHRyOXFj?=
 =?utf-8?B?V1VqY1BVZkU5SlFacE52eUZoL1dWWDJPNVUwell1c1ZTZFdRNSthb0ZqeVdM?=
 =?utf-8?B?WVBEeE93RDloVXFnbmNqMmFFeFRrVGlKdkYxZVl1cS8zUzB2WkFTbEIwTm5F?=
 =?utf-8?B?UlArR2lSMkZFL3Vyb3JvSUROdFpFemtSY0JGanI1Nm1CWUlwWVY2QUlVRFVB?=
 =?utf-8?B?ZnVBS042eDhqaktPUmRoQ3BqTUpGNVBzOGhhMGMyWTY1VG9FOG9RakZrZUl4?=
 =?utf-8?B?dXAxekt5aEZxNm9pNjFBOGdOVFdrRzJvZHZaVTNsalNZUHBqaHpxRDcwQVRu?=
 =?utf-8?B?YlZ2TnZ2UDJNZmhMVmtUSTFxWW1vdnlDRlBsb2xIRUVKQUV4UzhEU1J6ZzRl?=
 =?utf-8?B?OElJQXVvV1FscFlEazR1Y0J6bU9LZ2E0OEZFdXdtY0E2Myt4TkgzY3VXTkVk?=
 =?utf-8?B?c052cXR1UEU3eVVXa21hSk1jNmx2RkhleFFNaStaRUlVRzJvU2FCRmE1aEc5?=
 =?utf-8?B?Y0hJaHpTNkhZV1RTUS9rY2t0K3J5ZlFPaTlnbTdBVFUzeGJRQzFSYnFsYVd3?=
 =?utf-8?B?U21EbWtlbmVhR1BsSlN3WFlQYVF1ZE96NnB2bGxJNkZMdzRJMHkxajJWWGlM?=
 =?utf-8?B?UmpHTnAwV1dUWXQrZXQ0VlgxcFZuYUFmUEU3Rk1lRXdiU1cxemRNSnF5eWhN?=
 =?utf-8?B?VGJBZkRvTXErSWd1eWNTbGlHMklQTkNnTklnejdtaG9Na3NYRHhiaWhHYUFs?=
 =?utf-8?B?b0k0S3llUjJDczlqRHBZSGNSd2E4Mi90N3RoOVM5SWg4OUFONVp3TGlIZTBp?=
 =?utf-8?B?cW5CeG5aNXcyMjFKME93c1pPT1RtK21ZSVlzSloxd3pLMmN1UzY5MFpBLzFH?=
 =?utf-8?B?N2d6VjVWV3lGTUpMeVpzeXB0OHptUGtwWG9zNHJDRFlBZDlFZ2RSMUcvTFli?=
 =?utf-8?B?TE9aaE9CZnkwelhwcy8xc3ZDT0JUZUM0azNmZS9EYTMwZFk0Y3JNY3ptejNN?=
 =?utf-8?B?TmxnZklwa3JpM1N5c2RSdUkxaXExYUhFWm1IK3pBbTBic0cvSHR2ZXlrV2sy?=
 =?utf-8?B?VDRZTXIrREJBS1RxOXZ1YVRIazh4b0g2VnVxZ0pNTDlJTjluandJSkNiUjhW?=
 =?utf-8?B?SkVBTlIyTy9reWRRM0d3N3kvc05YSTdsZkJSRmRKYUNNUncwdGJiUjV5em1i?=
 =?utf-8?B?UlIyZDJsWEdoekZVaGFPMGhtdEk5L3JFMHY4ZkJNcWUvbkN1Z09TdllDZHBW?=
 =?utf-8?B?eHN1c3o0OG9tTXdJMWtGK3RFUGM4clE0bldyNmhBQjJQdzZLazQrdHYvRWpq?=
 =?utf-8?Q?2vINFwfxrhKEK6xjlmrsWK4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <689ABB4EE2F32E4B8FEDD7E0E0CCCFEC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cdcbd9-c3cc-42e0-7bdf-08d9c180e5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 17:16:00.1299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOVHP0r0yx5OjpechBWxoBUtmNFQnUkP2zqSFcXTDQr2MDST11Va5aMx7USPRzAnaxlH5S1gU3u6mWLcIp48kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7582
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IE9uIERlYyAxNywgMjAyMSwgYXQgMzozMCBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlk
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gTGV0J3MgcmV0dXJuIGVhcmx5IGZvciBodWdldGxi
LCB3aGljaCByZWFsbHkgb25seSByZWxpZXMgb24gdGhlIGNvbXBvdW5kDQo+IG1hcGNvdW50IHNv
IGZhciBhbmQgZG9lcyBub3Qgc3VwcG9ydCBQYWdlRG91YmxlTWFwKCkgeWV0LiBVc2UgdGhlIGNo
YW5jZQ0KPiB0byBjbGVhbnVwIHRoZSBmaWxlLVRIUCBjYXNlIHRvIG1ha2UgaXQgZWFzaWVyIHRv
IGdyYXNwLiBXaGlsZSBhdCBpdCwgdXNlDQo+IGhlYWRfY29tcG91bmRfbWFwY291bnQoKS4NCj4g
DQo+IFRoaXMgaXMgYSBwcmVwYXJhdGlvbiBmb3IgZnVydGhlciBjaGFuZ2VzLg0KDQpJdCB3b3Vs
ZCBiZSB1c2VmdWwgdG8gYWRkIOKAnG5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVk4oCdIG9y
IHNvbWV0aGluZy4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5j
b20+DQo+IC0tLQ0KPiBtbS91dGlsLmMgfCAxMSArKysrKysrLS0tLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21t
L3V0aWwuYyBiL21tL3V0aWwuYw0KPiBpbmRleCA3NDFiYTMyYTQzYWMuLjMyMzllNzVjMTQ4ZCAx
MDA2NDQNCj4gLS0tIGEvbW0vdXRpbC5jDQo+ICsrKyBiL21tL3V0aWwuYw0KPiBAQCAtNzMyLDE1
ICs3MzIsMTggQEAgaW50IF9fcGFnZV9tYXBjb3VudChzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gew0K
PiAJaW50IHJldDsNCj4gDQo+IC0JcmV0ID0gYXRvbWljX3JlYWQoJnBhZ2UtPl9tYXBjb3VudCkg
KyAxOw0KPiArCWlmIChQYWdlSHVnZShwYWdlKSkNCj4gKwkJcmV0dXJuIGNvbXBvdW5kX21hcGNv
dW50KHBhZ2UpOw0KDQpCZWZvcmUgeW91IHJldHVybiwgcGVyaGFwcyB5b3UgY2FuIGFkZCBhbiBh
c3NlcnRpb24gbGlrZToNCg0KCVZNX0JVR19PTihQYWdlRG91YmxlTWFwKHBhZ2UpKTsNCg0KVGhp
cyB3b3VsZCBiZSBtYWtlIHRoZSBjb2RlIGNsZWFyZXIgYW5kIHdvdWxkIGVhc2UgZGVidWdnaW5n
IGluIHRoZQ0KZnV0dXJlIChpZiBzdXBwb3J0IGZvciBkb3VibGUtbWFwIGlzIGV4cGFuZGVkKS4N
Cg0K
