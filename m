Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A353159887
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgBKS01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 13:26:27 -0500
Received: from mail-bn8nam12on2130.outbound.protection.outlook.com ([40.107.237.130]:49907
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729999AbgBKS00 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 13:26:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acxdJ3JnvSh6Y6x/EVeAkqmqy7TVmrBIUrRZYOpHssPMl224md3GUNhasevl4LR3yQW7kOY+3IbQrW70hFmrgTwowpfPAfNnQgNYYB718dyVEhY/aCxXLUzcROr1Saoca+peQrSeOUUtZAw5a953GHn8dQhmyXDLYpiCXyf/Zd7KlJLHGud/qAaexdvaPNdTCN/HpLWMI6VQVZAd0eYkdMd48HLk8hHuoERjqiVGtkXU0xEaxDyCeQ2xqk1ghy8H7j+b/nPP2QGsTTPyGmRIh5lYm7qQoby/6nrA/oZnoCx6StKioTJ89/BM9Ow7YStaoeMI76vk0U1EgEL5LbRJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3j9pRVvybtgSK9j4HFGSXB8R1S6Bq+ifgk7L37jtyU=;
 b=jyuzFoITFxbDsVn0CxJefEhRKu4PrSkL9B0yCNUKcJ5xWMWy9xzUaaGeDbEtlABt1gXNDcp+w51LQ08t2iv/u+aC3nxwMWoAb1NlMvqA2TUlwAQ1G02KlTxI5hW+ZJoSkmM7TFhgwb4BVv+0o8/g5v5Q/CRsKP/MRaLawP+uQM2AlIYNtXUHrUScYMAh7ikNC5cdV9b78mNijJeIQhefNVDyFFBPHyKNfAo9LNV2w9vUacKTH37VJGdWDaQFe3YPFolfF/9c+iUEVwLdZBNTiO50VX1AT5cpNhUSXilAPg9pfksOKwbkGdOSeC+iDlpcC7U6Fg94oMOW+a4mlpsyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3j9pRVvybtgSK9j4HFGSXB8R1S6Bq+ifgk7L37jtyU=;
 b=WCHM5vqLWgv+RwueKHT9JtB7H/sFO8LvwJUPr/NW/fupyhcRvMBxDqZqE04/d2TemMUemJVDYYUhxE3N7BblIjxCzf7U5BM10bm3+2eP2KoM4M5xjFyNaZvwR6WOnle2MGLGzW/3pi6+bB9MvphgIgZvzBHjV8JfsfuutUxABmE=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (10.169.172.155) by
 MWHPR13MB1728.namprd13.prod.outlook.com (10.171.147.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Tue, 11 Feb 2020 18:26:23 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd%3]) with mapi id 15.20.2729.018; Tue, 11 Feb 2020
 18:26:23 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>
CC:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kunit: run kunit_tool from any directory
Thread-Topic: [PATCH] kunit: run kunit_tool from any directory
Thread-Index: AQHV4HHxcx6AhuKPSkaTrpxC2rSXeKgVJGKAgAETQaA=
Date:   Tue, 11 Feb 2020 18:26:22 +0000
Message-ID: <MWHPR13MB08959C9951D826A9D0B19BCFFD180@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <20200211002551.147187-1-heidifahim@google.com>
 <CAFd5g47LFvRxHMJ+XHcw2dFe2xU+1GmDnXsm=STvCFAT74rm7g@mail.gmail.com>
In-Reply-To: <CAFd5g47LFvRxHMJ+XHcw2dFe2xU+1GmDnXsm=STvCFAT74rm7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36d5e490-4804-4fd1-bbc7-08d7af1fe5ee
x-ms-traffictypediagnostic: MWHPR13MB1728:
x-microsoft-antispam-prvs: <MWHPR13MB1728482F91EA6F2CF873210BFD180@MWHPR13MB1728.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(55016002)(316002)(2906002)(52536014)(7696005)(6506007)(66556008)(66476007)(53546011)(33656002)(5660300002)(8676002)(66946007)(81156014)(81166006)(66446008)(64756008)(86362001)(9686003)(8936002)(71200400001)(54906003)(110136005)(26005)(186003)(478600001)(4326008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1728;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l63R0fSkryJELQiQIKGhOGYnOkl9a9xtCy9GoPXcLI/KiE9i/6q9XBR2bto/ect8NCxNog9zqjznbPRVRIzLxqPvLrB5ffQRTbfpvYekLORNzWIpM24FV6txTYunJ/nCc38kE3okF9pB51g1BHfqiVwiP8lx3u016QA+Kwl2LeWDkAhW2qY+NoIoZMgyzQbLMvp6x4HVRWyiwFPedySeZh1iR0IaWbo85tDvRO73/o59ymRhn/Kp3MjFDR8WXoxjz3lzR3C+wtj6um7GJySnIOjHQfaqzsJhC5uFXHsIlHmwRGWx8IEAei275KNRLNegpanK+hws66Tj8ZGhkbnyIAeqITYvzeWZp8zXfWNlTTwgBT/DixiG0EIWRXFpOdPyOmB+waf6mkvlU9o/XwOHuTfLTT48H5Xfm6m4/UhmALioc4yzX+DIoQdWU18Yma9e
x-ms-exchange-antispam-messagedata: 5s2ZTjiHMJi12eFRXGDh/6/J0LKo1FoP2oWLLFX+QZk/nscbRfFknl1OKltHJ3E/nzS4cgLQQmD/OJq8ZxX2/GS2YJCzvIX5MqBrHiSelrSRMEdOBZUbXUeI+wvV8PC79hcByCKelDw/RjuqTpYF7Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d5e490-4804-4fd1-bbc7-08d7af1fe5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 18:26:23.0121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dK4eaCAzNu1d9gCt+vNsLgWoVugVG2FRXwudnGRIE9reYoCI7sDFkq0db1qBteyKppsDKnlq/Rd1Uo2Y6fxwzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1728
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJlbmRhbiBIaWdnaW5z
DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMTAsIDIwMjAgNTozMiBQTQ0KPiBUbzogSGVpZGkg
RmFoaW0gPGhlaWRpZmFoaW1AZ29vZ2xlLmNvbT47IERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29vZ2xl
LmNvbT47IERhbmllbCBMYXR5cG92IDxkbGF0eXBvdkBnb29nbGUuY29tPg0KPiBDYzogb3BlbiBs
aXN0OktFUk5FTCBTRUxGVEVTVCBGUkFNRVdPUksgPGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5l
bC5vcmc+OyBLVW5pdCBEZXZlbG9wbWVudCA8a3VuaXQtZGV2QGdvb2dsZWdyb3Vwcy5jb20+OyBM
aW51eA0KPiBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBrdW5pdDogcnVuIGt1bml0X3Rvb2wgZnJvbSBhbnkg
ZGlyZWN0b3J5DQo+IA0KPiBPbiBNb24sIEZlYiAxMCwgMjAyMCBhdCA0OjI2IFBNIEhlaWRpIEZh
aGltIDxoZWlkaWZhaGltQGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW1wbGVtZW50ZWQg
c21hbGwgZml4IHNvIHRoYXQgdGhlIHNjcmlwdCBjaGFuZ2VzIHdvcmsgZGlyZWN0b3JpZXMgdG8g
dGhlDQo+ID4gbGludXggZGlyZWN0b3J5IHdoZXJlIGt1bml0LnB5IGlzIHJ1bi4gVGhpcyBlbmFi
bGVzIHRoZSB1c2VyIHRvIHJ1bg0KPiA+IGt1bml0IGZyb20gYW55IHdvcmtpbmcgZGlyZWN0b3J5
LiBPcmlnaW5hbGx5IGNvbnNpZGVyZWQgdXNpbmcNCj4gPiBvcy5wYXRoLmpvaW4gYnV0IHRoaXMg
aXMgbW9yZSBlcnJvciBwcm9uZSBhcyB3ZSB3b3VsZCBoYXZlIHRvIGZpbmQgYWxsDQo+ID4gZmls
ZSBwYXRoIHVzYWdlcyBhbmQgbW9kaWZ5IHRoZW0gYWNjb3JkaW5nbHkuIFVzaW5nIG9zLmNoZGly
IGVuc3VyZXMNCj4gPiB0aGF0IHRoZSBlbnRpcmUgc2NyaXB0IGlzIHJ1biB3aXRoaW4gL2xpbnV4
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGVpZGkgRmFoaW0gPGhlaWRpZmFoaW1AZ29vZ2xl
LmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBCcmVuZGFuIEhpZ2dpbnMgPGJyZW5kYW5oaWdnaW5z
QGdvb2dsZS5jb20+DQo+IA0KU29ycnkgLSBJJ20gbm90IGEgY3VycmVudCBrdW5pdCB1c2VyLCBi
dXQgZG9lcyB0aGlzIG1lYW4gdGhhdCB0aGUNCmtlcm5lbCBzb3VyY2UgaGFzIHRvIGJlIHByZXNl
bnQgaW4gb3JkZXIgdG8gcnVuIHRoZSB1bml0IHRlc3RzPw0KVGhhdCdzIHByb2JsZW1hdGljYWwg
Zm9yIGVtYmVkZGVkIHN5c3RlbXMuICBNYXliZSB0aGF0J3Mgb3V0c2lkZQ0KdGhlIHNjb3BlIG9m
IHdoYXQgdW5pdCB0ZXN0cyB3ZXJlIGVudmlzaW9uZWQgZm9yPw0KIC0tIFRpbQ0KDQo=
