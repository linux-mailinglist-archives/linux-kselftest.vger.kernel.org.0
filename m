Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3082F2B15CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Nov 2020 07:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgKMGWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Nov 2020 01:22:14 -0500
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:60046
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgKMGWO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Nov 2020 01:22:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6ULNGLoWBecI7x5e6SL9kvhPLgiiA/QzoIBspIOpGC2Siz3b1wDzwv+vdJLNcA1H84itcnIfbb/cEnnLsMNsGKHHoYa7VtdyHTMK1bN2kRQ9Vd1gR1V86o/7gUc3LrUCCW89ql5eCWj2LYPHMGazb/i3knOWbqQT9jM1hKNndsa3imScpl86Ejsx+YthGs+Rpjjuc3QRj3gOgT13GEtMm4/mZCg5h9j30yw73quiZxLZwepyEHJPthz1amcJA9F0rLKApNOuLnwhBgA5gGsKIuDnwbaiBz5E9ZWGNtvAyKhpDZAFuS2nooXbVi0XaUjMnGNld0dnLjTGCRBLe6Xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqrUMjdEwvyZ9CYpLgTmkSPvRFKOUu8BGCGJCmXczBM=;
 b=OG033SzaHm0qy3X15rREYyEkQUVfSud+FRtgQoS85PYrj7M3a8wGumtq0jxZta+V2yYbwSlyELKimusMNxxa6fCxXRUMktLn+kzZPqHpm+eF8WCLrfmqY3PIsq42LQH4e+5hTRodziPXUPn1x7RE4gDULOAaODnCADvM7JfeasDwd4MSEMB1xKWWZQwNuqTr0qpc7r8Zv1TY2uFASoBfED/amz+FAtfUKwdwrSZPgv2vybl9isFAQJUAsP76UCAA/h83A/jUZ/6rbjGPXuaUc7FOBCVGMuxxdsExAM3LCYfLx+w71kXoXPLnZGPEqKqy8MB2BT5crtDDMqcvr7yP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqrUMjdEwvyZ9CYpLgTmkSPvRFKOUu8BGCGJCmXczBM=;
 b=DKyl37hcG2vRd9uYtfx4bw5MvnRMHSw7v/rdkNhbY6np69IA5IDMNM3wh+X2lbyXtGSGKMj2/o6fXqfO2m0RMB64zWTzEhJJXWXWa6iiiBmIYIxaVDgBosxbtPFsP0FxHZ1g9yfMZ6/H/iiQE6TlG665dGW0j7OJwXlBApqns88=
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com (2603:10a6:6:37::21) by
 DBBPR03MB5255.eurprd03.prod.outlook.com (2603:10a6:10:f5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Fri, 13 Nov 2020 06:22:08 +0000
Received: from DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::4c94:9185:81f3:1755]) by DB6PR03MB3160.eurprd03.prod.outlook.com
 ([fe80::4c94:9185:81f3:1755%4]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 06:22:08 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "vitor@massaru.org" <vitor@massaru.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
CC:     "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "davidgow@google.com" <davidgow@google.com>
Subject: Re: [PATCH v4 2/6] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Thread-Topic: [PATCH v4 2/6] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
Thread-Index: AQHWuR62EeKgSOJnRUivb8+yd7DovKnFmFyA
Date:   Fri, 13 Nov 2020 06:22:08 +0000
Message-ID: <0204dd7bd9107b03883c4ffeb9e2bf3d467ab9a6.camel@fi.rohmeurope.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
         <20201112180732.75589-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201112180732.75589-2-andriy.shevchenko@linux.intel.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: massaru.org; dkim=none (message not signed)
 header.d=none;massaru.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 388dfa2a-7138-4171-fddf-08d8879c72f9
x-ms-traffictypediagnostic: DBBPR03MB5255:
x-microsoft-antispam-prvs: <DBBPR03MB5255B17D89E3FDF4449EA898ADE60@DBBPR03MB5255.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdj3L+TlkpvoDvYD0sXwkJrQe4IlelmagstGYsq34WpkBke6ZmNjzViYj4WRDbe7GxcaDDfmFdF+UT/OGEts9HRV+ABJI6/J/5XZj97X9r72LJ/fWKRdpROLWNgoUExzzEJqN2Z3yt6c3IeuaL7uThFgVHsWaWC1b7bg7kdaJzOL3vosPnRqgoWScv01dknta30Zifeb9k1grylEMfXkXwaEWUNv1mtvWh1zhaRm8KTPP9F0g0TD+4aUjYyFqLxzLdIeXNEmrxMthsHR6HvyJewKKAdP+98U/DQ3ABBqqgsNfYY0dLr3D73wYnyXfm27
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3160.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39830400003)(136003)(186003)(6506007)(66476007)(8676002)(83380400001)(26005)(66946007)(3450700001)(54906003)(110136005)(2906002)(76116006)(91956017)(8936002)(66446008)(5660300002)(4001150100001)(2616005)(66556008)(64756008)(316002)(4326008)(71200400001)(6512007)(6486002)(86362001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0s6qFxnxQEc2Nq7i9A/jFLCZRAVAUmfA1rfgS1t/5CH88do6jKzlbbi7S9MGR0wGHQG8EtSLXbu0rlFsJigOgI0NXD9sZv9OPEiOTHMCXe7yWzn547d3Xu9cTWKt4hu7P5nLUhjukX4vhy5ZX7maM5jUHSzAVCkNSdFfJNKSTazmR6hxjXSVLlFHhSUBUwjmVxH5SOIMN0qOG7oHAVAqGIEZ/FVap/SxcMdl8WJ/V+pKoXaPekk4vJr5ToojmzAFKZ3LOJ4Vhb8cdlA1zLxfGQQPEITCPUkWyDb2yatfgvHsBhS+NoEy8Ff9/pycWSfyMaXBvX4ki3FWktknWZ4aNml/E29fJ/0Erhb5i9F96M9PIcwEi08U1QUleh9+3tHFnD0sP2ilPzzXBRixAo1Ba2qAm6UbwRM0GOJoKWw5rMnHkRLH9lESj9z91npsg4Tw0+3BW4e/JaoZe4yJzlCWDwzMmnvodSDFjE1NqOFhR9DZ34kTlCK9Tn57kBSrXtSiOP+CddN7bpiVda3xTuxoHGXhsNDFcNTOAo9tIfC+I0c7msE3QPfp+ky+RxgguA8YZdP2FB+D1jfDcNNQ1YhMCIuFCzHDHPhbJ46u5idOm0NBcR6yrhI2FTaCz63BftV2FaoYUlMinJi1lWNtvg/VRhb25aUU5D9CY9AypcMD2MLTYh1RUIHRICCefNBOQzQv9GYmHhPViZY15QUPsYWTXCXkNe4k5enIRbkKpjgdTl+BA2H4oex4DRyzcVh56I9g2qc5RpBznF53KVZPKnjvvfSh9ffYPbCEwQcWESpturJ1JjBm0aFADoJlJ/VvHvVkrqujPQrMzFaRGxPCiMBi6mYAnK74gLpAHmv9MgmJEhy7fdKBCsdKxjU9JBdMAWY77zjU8ywnYAvLbRzuL9M2tQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CBF1F0BDF211F4F87101FCB36872EBB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3160.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388dfa2a-7138-4171-fddf-08d8879c72f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 06:22:08.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5FDxhKQEBkBB86jQqgg1A85qK4mbhsObQ6saAW56eCkC+RD/orJQMl4PCu3qWTPSXHYKrfbmKiwfJQxEAB1e+Uozwd3EKjNqSNCG+P6XmQrAocVuG5MtW0bcm48MeAOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5255
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGVsbG8sDQoNCk9uIFRodSwgMjAyMC0xMS0xMiBhdCAyMDowNyArMDIwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOg0KPiBGb2xsb3cgbmV3IGZpbGUgbmFtZSBjb252ZW50aW9uIGZvciB0aGUgS1Vu
aXQgdGVzdHMuDQo+IFNpbmNlIHdlIGhhdmUgbGliLyp0ZXN0Ki5jIGluIGEgZmV3IHZhcmlhdGlv
bnMsDQo+IHVzZSAna3VuaXQnIHN1ZmZpeCB0byBkaXN0aW5ndWlzaCB1c3VhbCB0ZXN0IGNhc2Vz
DQo+IHdpdGggS1VuaXQtYmFzZWQgb25lcy4NCj4gDQo+IENjOiBNYXR0aSBWYWl0dGluZW4gPG1h
dHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5keSBT
aGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2Vk
LWJ5OiBEYXZpZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+DQo+IEFja2VkLWJ5OiBNYXJrIEJy
b3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiB2NDogYWRkZWQgdGFnIChNYXJrKQ0K
PiANCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8IDMgKy0tDQo+ICBsaWIvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAyICstDQo+ICBsaWIve3Rlc3RfbGluZWFyX3Jhbmdlcy5jID0+IGxpbmVhcl9y
YW5nZXNfa3VuaXQuY30gfCAwDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSBsaWIve3Rlc3RfbGluZWFyX3Jhbmdlcy5jID0+IGxp
bmVhcl9yYW5nZXNfa3VuaXQuY30gKDEwMCUpDQoNClNvcnJ5IGZvciBsYXRlIHJlYWN0aW9uLiBJ
IG5lZWQgdG8gYWRqdXN0IG15IG1haWwgZmlsdGVycy4gVGhlIEtVbml0DQptYWlscyBldmFkZWQg
bXkgaW5ib3ggZXZlbiB3aGVuIEkgd2FzIGluIENDLiBJIGhhdmUgb3duIGZvbGRlciBmb3INCktV
bml0IC0gd2hpY2ggSSBkbyBub3QgbG9vayBkYWlseS4gKEFuZCBubyBCcmVuZGFuLCB0aGUgZm9s
ZGVyIGlzIG5vdA0KY2FsbGVkICJ0cmFzaCIsIGl0cydzICJrdW5pdCIgYW5kIEkgZG8gb2NjYXNp
b25hbGx5IHNraW0gdGhyb3VnaCB0aGUNCm1haWxzIHRoZXJlKS4NCg0KSSBzZWUgdGhpcyB3YXMg
YWxyZWFkeSBhcHBsaWVkIHNvIGl0IGlzIGxhdGUgLSBidXQgSSB3YW50ZWQgdG8gc2F5DQp0aGFu
ayB5b3UgZm9yIHRha2luZyBjYXJlIG9mIHRoaXMgQW5keS4gSXQgbG9va3MgZ29vZCB0byBtZS4N
Cg0KLS1NYXR0aQ0KDQotLQ0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0K
Uk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZA0KU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAxRQ0K
OTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJlbmUg
RGVzY2FydGVzLiBKdXN0IHRoZW4gaGUgdmFuaXNoZWQgfn5+DQoNClNpbW9uIHNheXMgLSBpbiBM
YXRpbiBwbGVhc2UuDQoibm9uIGNvZ2l0byBtZSIgZGl4aXQgUmVuZSBEZXNjYXJ0ZSwgZGVpbmRl
IGV2YW5lc2Nhdml0DQoNCihUaGFua3MgZm9yIHRoZSB0cmFuc2xhdGlvbiBTaW1vbikNCg==
