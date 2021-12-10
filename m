Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467A470906
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbhLJSoO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:44:14 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:46616 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242028AbhLJSoO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:44:14 -0500
X-Greylist: delayed 5047 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2021 13:44:13 EST
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9IXIJW004411;
        Fri, 10 Dec 2021 17:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=AqoJ3K/R7Ptm39Lk/jWq+HhcoXXSCkttHiFtPTcyk5E=;
 b=p2G/+LoCxfELq3I1Xwg067FbNFA7TyTaHmMAblOcMhpJPpSaeuqekA8fM2FLvBlrxftS
 ajgMQbxbw4hQztSjh7Be5RjnRtDMlIvgGe93evGt3t4OdGiryJeT1QIbk3i5HZpnuiyk
 0vh6e4wj8RvJoLzmuERR7PO5q7vc1mt2vsjQ0zl+RAF/905tIV6eyGaeAC8FuIGrEm30
 1BGEFtPEkrclHCbEh6AT2j8zp7mXrP3wYUi8v11V/xVfxjG2jgcnvdzrWl3L2WbNYUAy
 0h30xfh8+l1QmG54DIv/3exVZA9cIzud0D+cBN9UQqZOlfSi5jwRcTbIqhz/CAlSljz4 Jw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx08-001d1705.pphosted.com with ESMTP id 3cthvdm8x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 17:16:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6qWzv1h/Xj4vFMUzkf9zvgWj6Iz1KdwhdrHf8lARfrolrVgUd20s1cvDQbYd77f/ZMtSYr0jaQw2srQO8i0HbxjufmZnol4JRbU490xzwrjvRBDP33LSy1VDF20Vnua0+wu0HloNOhkAihUtkkL+O3E1xN7Y8gCCrRmVs7JdsfXdA6kAmk9/KlcTL9NuZXxRitgQCIaMLeGVX/FffjpX/ILhWRS2KsUhQTXFGS1iWOaaOBnYRTyyh7fSgPvl5/oCj2LQFrzuL3jgzXV/tZZKbxHW2lUGD08lL0UNvsenCB5Eq7H47d0lrGWY32JTnpnd5osTIiP8uotKdUaoY8fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqoJ3K/R7Ptm39Lk/jWq+HhcoXXSCkttHiFtPTcyk5E=;
 b=P5m7+cf1l2YdS0Y/6SFIHhKICQI4NXXWihJ4+2HNtVyAR0t/mGqSUTtIHtZI4UFJhq6k7VcB6jAHG4dqf1NwgE5afbamxjW4Sj9DXWa/Tg11hYXfMLdrROPywyvhQDHYZnQhHtTvJfGF9qtUzEpV1JwXkkk+PmwK5ZIKWG+Uiqj+7VZMUPuYBtlOwnrm6sWstRlKnydc4sOhxGaFJcA2PYnfOtA4WGwCJHaVmfzXecNktC7UHlF0bHTPAC102jP526RABL4TzXmYX/566sonFqr1QV3YZk6eAfkcBhe+MlRxJY5x3e1qKpX2WyOxoqtjWwWQNdir2snJheZMpVKWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB3380.namprd13.prod.outlook.com (2603:10b6:a03:1ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.8; Fri, 10 Dec
 2021 17:16:13 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::88c2:9770:40f:4f8]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::88c2:9770:40f:4f8%7]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 17:16:13 +0000
From:   <Tim.Bird@sony.com>
To:     <sharinder@google.com>
CC:     <davidgow@google.com>, <brendanhiggins@google.com>,
        <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/7] Documentation: KUnit: Rework writing page to focus
 on writing tests
Thread-Topic: [PATCH v2 5/7] Documentation: KUnit: Rework writing page to
 focus on writing tests
Thread-Index: AQHX6y0G2Mj8SFCDEEmshz+ICJq6QawnSq2ggAPtaACAAMRGsA==
Date:   Fri, 10 Dec 2021 17:16:13 +0000
Message-ID: <BYAPR13MB250382B305D19D310AE45916FD719@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-6-sharinder@google.com>
 <BYAPR13MB2503EB20A1A804BEA0D08508FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CAHLZCaHWK_oUbnFMeZ7yeCg1XtwTzb1qYNtG8qgi_dOm4ZNafQ@mail.gmail.com>
In-Reply-To: <CAHLZCaHWK_oUbnFMeZ7yeCg1XtwTzb1qYNtG8qgi_dOm4ZNafQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc009b19-f5a4-48d2-e27c-08d9bc00c4c7
x-ms-traffictypediagnostic: BY5PR13MB3380:EE_
x-microsoft-antispam-prvs: <BY5PR13MB33804D6AA22ED9667207DCFFFD719@BY5PR13MB3380.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFZ9MLtmn0Oydbv7q5u6y03P/QvCysKXLbe5ridAtMYW6MDkERkoKXa3dqUApxXXODIGCd7VUr0WhXFbFCtU06EVADBZtG1DpKtECMFz5CjXYrQLdos1GYyv3CKmuTZmfyLnVxsRpqFhsS+bdbbecW6pRaASB31gGYn0/EFWOGm2bdz1mH1l1EtbKpR5jaIw6JemkTlx6B0Qx1Frjz+TH5pcdXdN6+jAXsMR2bvBlvKE8G9gcK84cgPHjCAHKp7yS0t2uzymuCQ50Wsoc+drB64XHYDrxS0a/rkNJvRixoVyMh+DxRp8l7fMGvFx/w20y8LZkd7sCsgPsXCZX0QCQHoexHXOE6rPmcyVjYlOaLGOG8zr4xmt/9tBC1x0ZagbUKfHXCHkC//hj64VMDMQUirStgy1Zia4eiQSnrbMlQDeKvxtnq4I57ugFeAfGvfoOsMPnnXweT+/w+sTyJIybvy7r+3x+rMRCzGn+6IZsUSR2IJTkqMbfCxWpqG5xpIBBmd0pyh3M7Hw2KEQp3wirLiisHSmZZMK4LDueQT1Hyo/xMxNfDMIB0NNL3GhcRK1PmvrmvWP9eo31F/fvKi33A0UAWQd/jP8q6rCzLjI5t+TJwhlm1iUhdY8w1bjoAd296iTVvhLvp4HUWffXDhFWewDm8RjTbRiy2LkEJoBpy8i0tDFA7f7MWNkMBz8QaiVYa3nKmSFKjlx+H/5cBGV8olNKb5/fOdlDYe3WVrhvgWPxFHG63vZf+90LTrCqawW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2503.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(558084003)(52536014)(38100700002)(26005)(2906002)(186003)(5660300002)(508600001)(9686003)(8676002)(8936002)(6506007)(71200400001)(7696005)(33656002)(316002)(54906003)(86362001)(6916009)(66476007)(4326008)(76116006)(82960400001)(66946007)(64756008)(66556008)(66446008)(55016003)(83380400001)(38070700005)(122000001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVVnYnZKMCtsUEFyWWhkcEtVMW92TDNVTGVWclNoVmw0QUVBeWV2K2R4a2pz?=
 =?utf-8?B?ZmZ3STY0Tkp1cjhCcE4vZ2dYUGl6SUtyQXNIUi82T2NVb01iZnBFY3ZFbGN1?=
 =?utf-8?B?YlMwdFdORTRqczdnUHpUdXM3aC9GZS9UOXVhN3Q5c1R0di9EaDZaSnJQNEl0?=
 =?utf-8?B?NFhWT2xCekZlMWlGV1IxSTYzOEkzRkd6OHhTc2pQR2dHUTJ1dkVSOGZXczJy?=
 =?utf-8?B?K2lucTZFenpndVkvdi9hak5MSmdLWUJqbzgzcGloMUMxMEtSejBkUjRjNW4z?=
 =?utf-8?B?RWZibkR0YU56Qks1NUhPMWlubDBSUFU1L2Y4c01RR2RsS0IyQmNROVNSWlZG?=
 =?utf-8?B?WGUxVk1CSU85N3FnY0lFY0N3emVIOFlQK2EwcWlHeE1aVitXbjlvaVMyejlK?=
 =?utf-8?B?eFZDUEV5ejRkdW1JMnVRTVREd0tzbVVVN0lIQy9uVStwcCtEdGVlQWJCdkVR?=
 =?utf-8?B?QmZNSVdnRUhRZXpaN2NVZHpKWE53R00yZ28rcE0rSmZISmtoSlFySFZKaFFE?=
 =?utf-8?B?c1JFbHhSTkUwckpyNlJ6V2NsK1lhMDVoOXk4Zjh4S1Q1Q1cyMEpSWDBFWDRM?=
 =?utf-8?B?L1J5dnlycUYrbTdhWUFtajlyMzNhQVJjeTgrOUsvcVZ3VjlNTHFoRlMxY2dO?=
 =?utf-8?B?Q2JUL2NNUFk0ZVFUT0djZitlT0pXYzVoR1pZUkdUUFlhZmYyNWZXMmRRMjht?=
 =?utf-8?B?SDRoMERWOXJ2R0tGbENZTFE4dU1RSERxMU9NQ3JuSFJpeVZmSHdELytiaVEx?=
 =?utf-8?B?RlgvUm1pa0RqZjZDcTEvUXZ4Y05XanoxcGZHbVhmTlA1dHZlRkcrL0NHTFVW?=
 =?utf-8?B?TisvRW1SYmp1cVNOdGwwYXZFajVaRTZYeTNnTFZpeW14VWtOOXhXL2FpdzU3?=
 =?utf-8?B?Mm1oU3hzOVpJQlFLT3Y0WDhGTUM5UTBCcnNSQVU1Y1VMUFJRa1kwMEpwRlVa?=
 =?utf-8?B?TkJ4VVFQVGU0Sm56RDNGR25pVzZOSmFkbExENjN6NzlEQ0pCb2l6cEJRcWhz?=
 =?utf-8?B?TkFmM1FrU1dWT2tYVTVub2xxRmRhL3ZsaUpDSUcrbjZYK214VUFVVWlJdnZu?=
 =?utf-8?B?aHZYTVY4RWIwUHF5NG1xZml1UW05YUFKamZNZ29lS2tVMmR3TWpQZjdoeEdq?=
 =?utf-8?B?azZES3pxRVFhOGNZMUVRZmlHTzFnUU9RcExxdThIM0sxSUZhN0FNOG9VRU9X?=
 =?utf-8?B?aElMdDJHMU9uNEhkVjVsL0U2OER1ekxxWHJlKzlDdUpKUG1sYWZhZUlZWlYy?=
 =?utf-8?B?VCsvZXhJOFVjbGlDWUE0VDJHMktZS2t6RzRQZW16dXAvM1ZCSnBLSFZnR1dO?=
 =?utf-8?B?UFRVQVBUekdBRktvZDNONmlaWVVUY0NvU3J1N1B6d09FSnhVcUtYdzdsczNq?=
 =?utf-8?B?ZlNQdUdrSlVJL0VXRFV6Mm53YXRWK1RPSzhJWU51c0dLOUx4OFFzSVM3d1Yz?=
 =?utf-8?B?L3JPZjI4QVUyZ0xBWUlzT0lWbnlDVytBeEtIUFFGakJ3bDhmZHVzRVliTER3?=
 =?utf-8?B?QjA2SFJmdmlVT1JCTWNuTGIyTkl2Szdwd1Y1c3FmNXFQUTdqQTBKbG1tQnNW?=
 =?utf-8?B?MHBUbHpydmVZTXQvaHkrcGxIb0k0L3dITzVjM00vODJyNEdTbmV2WVNPL1gx?=
 =?utf-8?B?ZW9CNkIvcmw4VE5rN3FoTXovL2k3dXVZWFIvbFMrYXU1ajVtZC9IeUNKcmRp?=
 =?utf-8?B?RWlpODAyTFp0RXVhWU9YTS9McFZpa1NSSkNlUHpEci9IbDMvZGM4YzlkMDhs?=
 =?utf-8?B?a1Q4eWZwZURidnBocmNpTnR4REJDSE13MU9TazJXZFBYUUhicnRHRmVKQUxB?=
 =?utf-8?B?bmpqM1BHeStCbjZwSCtSaGtFRFA5cWZMRjB3NWxBQTluNDRvU0xRR0lYSG81?=
 =?utf-8?B?WEpLcnRpMlY2VGtaV3BHZlRoMCt6a0dtWEJxQTAvMGMzK1VjNXhIeVVmcDlG?=
 =?utf-8?B?QU9DaGlZZFlWK1drbjdwMTdtekZIZE1GZUFCRVFlZjdFdzM4bmVnVHEyUWVK?=
 =?utf-8?B?ZjJRMjNualhMcW9CSHlzVXZtR1BjUU9GL2dYN25EeFVjYWNmUGc4WmQrQUtj?=
 =?utf-8?B?YUZwL2tLTFRFWDlCZ0J1WkdENm9FTEJRZGpLMGtMUlJLOEhxdmU2QmZOOGQ0?=
 =?utf-8?B?SDV2aTg5YXJWbnRPdTVKNVVkRWRsbDIzT3oyMVVkOEg5ZDdQdk95SExjdzlw?=
 =?utf-8?Q?l4ZZVxPDXR4s+qluuwbR19s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc009b19-f5a4-48d2-e27c-08d9bc00c4c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 17:16:13.6002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWXGE2imK7KHbGj/MiX7SYrXJAt1M/xA7hJ+HraYStLsqM8t+7DFbnfbVRWdzJuVumu7NFcKHsKDCwIuTYVgzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3380
X-Proofpoint-GUID: lz7Aw7Afi0osHoxU5aj-FEgUNGWfUSs-
X-Proofpoint-ORIG-GUID: lz7Aw7Afi0osHoxU5aj-FEgUNGWfUSs-
X-Sony-Outbound-GUID: lz7Aw7Afi0osHoxU5aj-FEgUNGWfUSs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_06,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100097
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

VGhhbmtzIGZvciByZXNwb25kaW5nIHRvIG15IHJldmlldy4gIEkgcmV2aWV3ZWQgdGhlIHJlbWFp
bmluZyBwYXRjaGVzICh2MyBwYXRjaGVzIDYgYW5kIDcpDQphbmQgZm91bmQgbm8gaXNzdWVzLg0K
DQogLS0gVGltDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFyaW5k
ZXIgU2luZ2ggPHNoYXJpbmRlckBnb29nbGUuY29tPg0KPiANCj4gSGVsbG8gVGltLA0KPiANCj4g
VGhhbmtzIGZvciBwcm92aWRpbmcgcmV2aWV3IGNvbW1lbnRzLg0KPiANCj4gUGxlYXNlIHNlZSBt
eSBjb21tZW50cyBiZWxvdy4NCi4uLg0KDQo=
