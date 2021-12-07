Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFF46C1DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbhLGRgt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 12:36:49 -0500
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:38168 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230317AbhLGRgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 12:36:48 -0500
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7GQ93D029047;
        Tue, 7 Dec 2021 17:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=+1vwxVlNdflIo+dTsbzswv+CB4OLjGfytUKKuplByuE=;
 b=Nc7k2DbJffjcg4nKuYsezCfydJDyRT+Y+DAYSG/MBJckRJi9qX6uUY6KtyisCkUGuALN
 7cPckMW28HvxbyhL83sCyZQT0kXxqTpiQNp+oCdsxqis4Xas9MZHS03sF91U/EvhFb4i
 xhB9l8vZS8P5Ndz+AqniIiZ76A5IlmZ3zgawQSrXPg88xXwIclOAG9QUDCSw0Y7brEHJ
 4tySgriX90JirumO2WfI4QKg3sPkZdSyZ7J6hLvJC/MUthq+ixGTEWOeB3Rnrdwn86Id
 04nafppCOl6pJYgmwihp2FzYYjCTQdekbOyqZLn7IMHdXRFYKtibayKJfpdZuxH6HLML Kg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mx08-001d1705.pphosted.com with ESMTP id 3csvjw0n40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 17:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF4x9CWmN3WocBEF4CAQVezPSMBcL6LkjtAi0mCJmXZ5gfIqugnx2XAhn94xmA+xO216DQXGCi7GRUl0OVvT58zXkPS5KEWr79Iai8Jq70U4AonszFqaz8vAwANfJo+BXVE1m8te4/259vYhPbk2a0C6WRfFOHxczQ9tK/aQdfD8VZ5zKRnEh1h5CKb/qZakfEYEToaL7jJLUKwVNnsR9ye273/SvsywkL9o9PgaMnaM9n5+Q4977pumIZN2yz8R9cjamgKPsHDZ54jaP/1jrifmOIqm2D2KHfduCb//zFS6tRc7iCajTwqrbeNG9ouDSBSfwAGzR/kB/APKpl7NXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1vwxVlNdflIo+dTsbzswv+CB4OLjGfytUKKuplByuE=;
 b=QFvbHy67o4tZO9OM3FkOy7YcSNwa0uJfQiMdDhjQckqLJF6eFfqthdumcqERdC+PR3F9ZP2NU/XcuMn8Spu+Tvw048zTP6kI3cvbYyQV3JFCt3H/1EONHFw1inwjN1dmRT92gKjN2CjAgaD0DtdpyeWcB4Tk+jlM5EAVxRmHP6fjt3l0FN0mJjQOicytpCAo8y6POqsWEw9/mTby0K9xNW6G7DE6RwQ63YH3M0nUXbAkjyd29izeLXdjABrcPuFxvKbUktjq98sb67hwt3xJDZIDWBxZB0hsTpghDYaCEhNxgg15v10t4Jn4KC0MbbZRJxGqe9gY3/5IB0xXSgpwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BYAPR13MB2791.namprd13.prod.outlook.com (2603:10b6:a03:f9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.10; Tue, 7 Dec
 2021 17:33:03 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::88c2:9770:40f:4f8]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::88c2:9770:40f:4f8%7]) with mapi id 15.20.4778.007; Tue, 7 Dec 2021
 17:33:01 +0000
From:   <Tim.Bird@sony.com>
To:     <sharinder@google.com>, <davidgow@google.com>,
        <brendanhiggins@google.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/7] Documentation: kunit: Reorganize documentation
 related to running tests
Thread-Topic: [PATCH v2 4/7] Documentation: kunit: Reorganize documentation
 related to running tests
Thread-Index: AQHX6y0CWDVBvUNu+kiqh0Po2pCup6wnSL1A
Date:   Tue, 7 Dec 2021 17:33:01 +0000
Message-ID: <BYAPR13MB2503F47AA79D51CDE321AB21FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-5-sharinder@google.com>
In-Reply-To: <20211207054019.1455054-5-sharinder@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c643d47f-57da-4001-dc7e-08d9b9a79e5f
x-ms-traffictypediagnostic: BYAPR13MB2791:EE_
x-microsoft-antispam-prvs: <BYAPR13MB2791F0404925A94E5D9F74B1FD6E9@BYAPR13MB2791.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjVggXfn5NYhn8MgYHtN4MKNhs2EO10i0j9pc3jULJKYtDTwI2Ott1GBspR6S+KEmXb3y3VFN/1Qy4sITtXAw8ZDtH6rMEhExs35NZX+ajctw1NaBoQwCiUAM0McBmV3G70uhH0EQ9i9dFlsRtASwg8CGnkjakTy21FjXqFNjotqO9fe+vZxSU58zvfcf1dz1UBAl5TxYFN+B9hwMW4ON7qYKYFkgWGCplqFWDlLzNl4QL6cdPSZblB8LuTcJTLHYxaBQ6HZuMsRW7ts/a+xiCUBEhbRS26u5iuwUDiqFf7GE7IAPN+fQsiK1ahP2mfzc84dpoZVW5rEXYO/gKkGZegfO7vAmzRv33mFF6Uq/d3wDVtnCEf5aZPClW/VbHrEaJ+QByOYkPYtWiNqTZ2O2VrTbANiXDfyKdF7Moq3AQiufrOW820oOa/VpTmo1uwK596uR5KogIsNxvMf+BVvwelrcXXVKXeWyUxAyVo9vC0d82RlvkimF3wehZj5a/CZFkGX6vqqp5ctzIzyT2vrSXo6rRlDXKm156aIobncZ0jhEn4uLWpEMF2B7m6JUCpdgChSx9cGg/OZklDwRZ8ELy7FqvbR1iAI6MUU6fXorX7mFvTTK+BoCis9k6HGlrRX86pxv9ISIFYkI/7nORPHBLo3VpNOeDdOJ3OHK/jLvc0lpCUWEhDZ9l6kBGSOJ17oRx11uBkjVu+01v5qGnCKdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(66946007)(33656002)(186003)(66476007)(110136005)(122000001)(76116006)(52536014)(54906003)(82960400001)(38100700002)(508600001)(83380400001)(26005)(71200400001)(5660300002)(86362001)(38070700005)(66446008)(64756008)(55016003)(6506007)(8936002)(316002)(8676002)(4326008)(66556008)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDJtM0NNMEVSRkJHT1hyc2g2Wng4QkhBcTdMZlJMUXZweUIzbUNOZjA5RnZZ?=
 =?utf-8?B?WW80eWRyZzU0b2ZTS0d6bk81SEJiTk0vV0hSRVpaRGxHMUNqUWl3NVpxSnpP?=
 =?utf-8?B?T2NaUUtQaUxoZFdTZEg2ekFsdWJXRDNYZExtMS9sTmJnSWlPTnMwVHp4QWoz?=
 =?utf-8?B?MGdGbVNNbkJkMVFIUWNDUXBiTGpBWFBCbURrcDN0cEI2MTNmcFpoRTVXSXNI?=
 =?utf-8?B?NUo2UVFWYndMbU5oeG9UK1lEWWhYY2thU2Rpb2hMbDlMVUtJckRqMkhnaFZ1?=
 =?utf-8?B?eG8xQlRNemJiK2NoTm5PMiszSXNpMGZxVVI3SWpGNkNNclNFUCtCdWlQTS9M?=
 =?utf-8?B?NHpIUjdXNHlkMSs1dFhHb2c2NDVkWlEvT3pGQkRxNUxNaEtTd1hob3NLc3Vt?=
 =?utf-8?B?YzVpYUZrZjhwaWRsczJnV3NXNXpjd2ROdytLdGozU1dyYXQxNzdpa0dqY2Nz?=
 =?utf-8?B?aTgvckhob2ZvTGxtdUVaNVo5VnFxZnFVU0dVcVpCbVloUU1kbmVWbno0WENP?=
 =?utf-8?B?S0JFNHN0RXN3S0dPK09XWGVHUmxoT0dSMHRCL1FjdktQdWVGa3dJNUV0amFZ?=
 =?utf-8?B?d2pRdFJDdHBNQUVWMlEyYnhBT04wVHprbzhEMElucU9UdGlWekVlUUVWOHRM?=
 =?utf-8?B?eTNVWkY4VWR2UndOV2FiVVp6Znk4UHhnR2krckNXMDl3bnJKZ21jb01wWks3?=
 =?utf-8?B?SG9UcEJubkM2ZEYwQlZJZEJrQ0lKNmIxVXB3RTU0U2c0Vi95d2NLVUFmaVpq?=
 =?utf-8?B?djdOTWJ0M1A1OXBnWTFTZ1oxV2ltTEtMT3paVjNvV3h3Q0JuVjJaYi9oTVlG?=
 =?utf-8?B?ZWNHTGpmbXlhcjhZdWQ2aGM0T1ExYTArQ1BzOHhIVEZOZm8ySW96L01rblhG?=
 =?utf-8?B?aFo2bTFENmEwdTNqUzZGYkxOVUxFZHJFLyt5SDh0WXh5RE9EU05yb0FybVJK?=
 =?utf-8?B?TEVYVGRzM3FkcVVoWnJ2blhVTUNKUGhacjlWaStpTXdhamg5eWZVYXJXdGIw?=
 =?utf-8?B?SDFrVlNWVUNZcU5VdUJ4TWVxS2VGcE9QcEh0ckpvei9DdittUDZyZFN1eDFD?=
 =?utf-8?B?L0lDUWdkYWRrbmNOaHErM2tJa2Z1Rkt3WGpPcTZOc3d3OExIY0ZuVStOYnk3?=
 =?utf-8?B?NUszdHNWM0tOczVRMDRHSnFkNmJob1kxZU1zWm5URHA1akZRY2lRTU9JR2VM?=
 =?utf-8?B?OWt6aEZmdUphWXBkNW8wbTVGaWdDYU9QVVdhMkZORkQwSmNSakFuMmt1Y0JC?=
 =?utf-8?B?RFVpa0ROSU0rMW4xazJHTXlha3Y0L0FKWFYrK0lUMXRyWGMwU05FbEdMZ1ZV?=
 =?utf-8?B?SjFKS2k4Q0IvbWh3RFlkQmkzQkVZdDR5MzhDZ2xjVEsxdlpyLzhJTm1PT1dN?=
 =?utf-8?B?NVZuSzZzMmVPL1dtWE1qZFJleEJGOFB5V20wUThtYVI1NC9TdW1ORE05eUxn?=
 =?utf-8?B?ZGZhRXg1UjQzM3ZOdEF2eUlpcVI4MUh1YVJtYnBGN3VRQnRpd3BmV1ZsUGlI?=
 =?utf-8?B?QWJOd0RLN2V5OWJQRFNMWW04ajBscDZVajZ6dTQvOFhMUFV0TzFhdVFxODBi?=
 =?utf-8?B?dElaSmpUbG8rRVY2ZndOOTJONWREUW16dWhTTHk1ckN2aEpUL1dlT1J4RC9R?=
 =?utf-8?B?V1IyTVlvV0tCcVg5a0dZQUF0VFdRMlZDMnpMS1YvWTZRclJGd1QvdENXMUt6?=
 =?utf-8?B?MzRuQzZvN1lyRjBWcGN4UGJDVXhVODFoMHZKRnJ3Q0JPWi9HZ0VtOFVQak54?=
 =?utf-8?B?SHBHVFREeFdkaHdrbG9QcHZ6U093MzlCb201RzJLeHpzNVdvOERkQnZNQ2x6?=
 =?utf-8?B?dVlUSURLYUpVdlBXd1VYK2Jnak9NcDhHVzAwQzI0bEwyeWNFSW12YXl1WlBt?=
 =?utf-8?B?TWFhNmZCYnNDQWd2bE5SYmpNbFU3eC9WaFBtTmZ6OGhDajFISVh5RDJETTBt?=
 =?utf-8?B?Rlp5ZFREdE5aSnhCSE5ZTkpmSjRRT0xpd2hWOXpkL2lKd09QTFh5aDE1OTdT?=
 =?utf-8?B?UUJxL2NsWURJbE5jS1lSTWNFdTdnNFlOYXZxazFnQ2hRNlNLR3ZLaEpZNXlz?=
 =?utf-8?B?YjdreWdnK2xUUTFSZ29UUjY1b3Bvcm9nQ25wQ1NFZ1JLdlVkZ2R4WklUTm41?=
 =?utf-8?B?dGFUOWhpWVh4RTZxdXBQR0tzVGdlV2hVZjNiaC95UWVxcFY0a01QUHFsMU1R?=
 =?utf-8?Q?l3iTcuOfXAJwXxdxifVNDIk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c643d47f-57da-4001-dc7e-08d9b9a79e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 17:33:01.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHDyIZ6qGl8+EW0aDl1FAxKdv7NdC3HgYUkJFruWv9uAk9kLYFOlH5W0eXZEI1w4qvdDZiLiXL2qij1fcuqW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2791
X-Proofpoint-ORIG-GUID: dWzNl9Qk8UhmkAEJRPpYp_rUPOZ5INBw
X-Proofpoint-GUID: dWzNl9Qk8UhmkAEJRPpYp_rUPOZ5INBw
X-Sony-Outbound-GUID: dWzNl9Qk8UhmkAEJRPpYp_rUPOZ5INBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070109
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXJpbmRlciBTaW5naCA8c2hh
cmluZGVyQGdvb2dsZS5jb20+DQo+IA0KPiBDb25zb2xpZGF0ZSBkb2N1bWVudGF0aW9uIHJ1bm5p
bmcgdGVzdHMgaW50byB0d28gcGFnZXM6ICJydW4gdGVzdHMgd2l0aA0KPiBrdW5pdF90b29sIiBh
bmQgInJ1biB0ZXN0cyB3aXRob3V0IGt1bml0X3Rvb2wiLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SGFyaW5kZXIgU2luZ2ggPHNoYXJpbmRlckBnb29nbGUuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50
YXRpb24vZGV2LXRvb2xzL2t1bml0L2luZGV4LnJzdCAgICAgICB8ICAgNCArDQo+ICBEb2N1bWVu
dGF0aW9uL2Rldi10b29scy9rdW5pdC9ydW5fbWFudWFsLnJzdCAgfCAgNTcgKysrKw0KPiAgRG9j
dW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvcnVuX3dyYXBwZXIucnN0IHwgMjQ3ICsrKysrKysr
KysrKysrKysrKw0KPiAgRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvc3RhcnQucnN0ICAg
ICAgIHwgICA0ICstDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDMxMSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMv
a3VuaXQvcnVuX21hbnVhbC5yc3QNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9u
L2Rldi10b29scy9rdW5pdC9ydW5fd3JhcHBlci5yc3QNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL2Rldi10
b29scy9rdW5pdC9pbmRleC5yc3QNCj4gaW5kZXggNzVlNGFlODVhZGJiLi5jMGQxZmQ3NDljZDIg
MTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L2luZGV4LnJzdA0K
PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9pbmRleC5yc3QNCj4gQEAgLTEw
LDYgKzEwLDggQEAgS1VuaXQgLSBMaW51eCBLZXJuZWwgVW5pdCBUZXN0aW5nDQo+IA0KPiAgCXN0
YXJ0DQo+ICAJYXJjaGl0ZWN0dXJlDQo+ICsJcnVuX3dyYXBwZXINCj4gKwlydW5fbWFudWFsDQo+
ICAJdXNhZ2UNCj4gIAlrdW5pdC10b29sDQo+ICAJYXBpL2luZGV4DQo+IEBAIC05OCw2ICsxMDAs
OCBAQCBIb3cgZG8gSSB1c2UgaXQ/DQo+IA0KPiAgKiAgIERvY3VtZW50YXRpb24vZGV2LXRvb2xz
L2t1bml0L3N0YXJ0LnJzdCAtIGZvciBLVW5pdCBuZXcgdXNlcnMuDQo+ICAqICAgRG9jdW1lbnRh
dGlvbi9kZXYtdG9vbHMva3VuaXQvYXJjaGl0ZWN0dXJlLnJzdCAtIEtVbml0IGFyY2hpdGVjdHVy
ZS4NCj4gKyogICBEb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9ydW5fd3JhcHBlci5yc3Qg
LSBydW4ga3VuaXRfdG9vbC4NCj4gKyogICBEb2N1bWVudGF0aW9uL2Rldi10b29scy9rdW5pdC9y
dW5fbWFudWFsLnJzdCAtIHJ1biB0ZXN0cyB3aXRob3V0IGt1bml0X3Rvb2wuDQo+ICAqICAgRG9j
dW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvdXNhZ2UucnN0IC0gS1VuaXQgZmVhdHVyZXMuDQo+
ICAqICAgRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvdGlwcy5yc3QgLSBiZXN0IHByYWN0
aWNlcyB3aXRoDQo+ICAgICAgZXhhbXBsZXMuDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2Rldi10b29scy9rdW5pdC9ydW5fbWFudWFsLnJzdCBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xz
L2t1bml0L3J1bl9tYW51YWwucnN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwMC4uNzFlNmQ2NjIzZjg4DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvcnVuX21hbnVhbC5yc3QNCj4gQEAgLTAsMCArMSw1NyBA
QA0KPiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKw0KPiArPT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiArUnVuIFRlc3RzIHdpdGhvdXQga3VuaXRfdG9vbA0K
PiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiArDQo+ICtJZiB3ZSBkbyBub3Qgd2Fu
dCB0byB1c2Uga3VuaXRfdG9vbCAoRm9yIGV4YW1wbGU6IHdlIHdhbnQgdG8gaW50ZWdyYXRlDQo+
ICt3aXRoIG90aGVyIHN5c3RlbXMsIG9yIHJ1biB0ZXN0cyBvbiByZWFsIGhhcmR3YXJlKSwgd2Ug
Y2FuDQo+ICtpbmNsdWRlIEtVbml0IGluIGFueSBrZXJuZWwsIHJlYWQgb3V0IHJlc3VsdHMsIGFu
ZCBwYXJzZSBtYW51YWxseS4NCj4gKw0KPiArLi4gbm90ZTo6IEtVbml0IGlzIG5vdCBkZXNpZ25l
ZCBmb3IgdXNlIGluIGEgcHJvZHVjdGlvbiBzeXN0ZW0uIEl0IGlzDQo+ICsgICAgICAgICAgcG9z
c2libGUgdGhhdCB0ZXN0cyBtYXkgcmVkdWNlIHRoZSBzdGFiaWxpdHkgb3Igc2VjdXJpdHkgb2YN
Cj4gKyAgICAgICAgICB0aGUgc3lzdGVtLg0KPiArDQo+ICtDb25maWd1cmUgdGhlIEtlcm5lbA0K
PiArPT09PT09PT09PT09PT09PT09PT0NCj4gKw0KPiArS1VuaXQgdGVzdHMgY2FuIHJ1biB3aXRo
b3V0IGt1bml0X3Rvb2wuIFRoaXMgY2FuIGJlIHVzZWZ1bCwgaWY6DQo+ICsNCj4gKy0gV2UgaGF2
ZSBhbiBleGlzdGluZyBrZXJuZWwgY29uZmlndXJhdGlvbiB0byB0ZXN0Lg0KPiArLSBOZWVkIHRv
IHJ1biBvbiByZWFsIGhhcmR3YXJlIChvciB1c2luZyBhbiBlbXVsYXRvci9WTSBrdW5pdF90b29s
DQo+ICsgIGRvZXMgbm90IHN1cHBvcnQpLg0KPiArLSBXaXNoIHRvIGludGVncmF0ZSB3aXRoIHNv
bWUgZXhpc3RpbmcgdGVzdGluZyBzeXN0ZW1zLg0KPiArDQo+ICtLVW5pdCBpcyBjb25maWd1cmVk
IHdpdGggdGhlIGBgQ09ORklHX0tVTklUYGAgb3B0aW9uLCBhbmQgaW5kaXZpZHVhbA0KPiArdGVz
dHMgY2FuIGFsc28gYmUgYnVpbHQgYnkgZW5hYmxpbmcgdGhlaXIgY29uZmlnIG9wdGlvbnMgaW4g
b3VyDQo+ICtgYC5jb25maWdgYC4gS1VuaXQgdGVzdHMgdXN1YWxseSAoYnV0IGRvbid0IGFsd2F5
cykgaGF2ZSBjb25maWcgb3B0aW9ucw0KPiArZW5kaW5nIGluIGBgX0tVTklUX1RFU1RgYC4gTW9z
dCB0ZXN0cyBjYW4gZWl0aGVyIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLA0KPiArb3IgYmUgYnVpbHQg
aW50byB0aGUga2VybmVsLg0KPiArDQo+ICsuLiBub3RlIDo6DQo+ICsNCj4gKwlXZSBjYW4gZW5h
YmxlIHRoZSBgYEtVTklUX0FMTF9URVNUU2BgIGNvbmZpZyBvcHRpb24gdG8NCj4gKwlhdXRvbWF0
aWNhbGx5IGVuYWJsZSBhbGwgdGVzdHMgd2l0aCBzYXRpc2ZpZWQgZGVwZW5kZW5jaWVzLiBUaGlz
IGlzDQo+ICsJYSBnb29kIHdheSBvZiBxdWlja2x5IHRlc3RpbmcgZXZlcnl0aGluZyBhcHBsaWNh
YmxlIHRvIHRoZSBjdXJyZW50DQo+ICsJY29uZmlnLg0KPiArDQo+ICtPbmNlIHdlIGhhdmUgYnVp
bHQgb3VyIGtlcm5lbCAoYW5kL29yIG1vZHVsZXMpLCBpdCBpcyBzaW1wbGUgdG8gcnVuDQo+ICt0
aGUgdGVzdHMuIElmIHRoZSB0ZXN0cyBhcmUgYnVpbHQtaW4sIHRoZW4gd2lsbCBydW4gYXV0b21h
dGljYWxseSBvbiB0aGUNCg0KdGhlbiB3aWxsIHJ1biAtPiB0aGV5IHdpbGwgcnVuDQoob3IgJ3Ro
ZW4gdGhleSB3aWxsIHJ1bicpDQoNCj4gK2tlcm5lbCBib290LiBUaGUgcmVzdWx0cyB3aWxsIGJl
IHdyaXR0ZW4gdG8gdGhlIGtlcm5lbCBsb2cgKGBgZG1lc2dgYCkNCj4gK2luIFRBUCBmb3JtYXQu
DQo+ICsNCg0KVGhlIHJlc3QgbG9va3MgT0sgdG8gbWUuDQoNCllvdSBjYW4gYWRkIGEgJ1Jldmll
d2VkLWJ5JyBmb3IgbWUgaWYgeW91IHdhbnQuDQogLS0gVGltDQoNCg==
