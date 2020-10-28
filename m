Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A429DFC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Oct 2020 02:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgJ1WMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:12:37 -0400
Received: from mail-eopbgr80120.outbound.protection.outlook.com ([40.107.8.120]:59271
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730835AbgJ1WM2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fym6HEowA2/8nYYzjAi5rCnU+QKp4nA0c9Z+sjW+HZ3GBlgCrfu5y5eCiSFTQjSIRCA/r0Z2Th7WeFPjmIdQwqPeljXx0tZHl/eSk/OWppepiL1L7nFj36Aq05pdTEdjcv7X3OGw90bXUF6VDYomnLT7Z4uICs98CDtCswd5CRhPosmmmj4yAr+u70AoRjxe5RIooi1KjrqIAfWnK59tBGpWUDmQrdtcLcY9t5Y+xq5VyrxfPor+iTvRJbbT4IVE6iCYTyJjxAkHu8NlOZU6bKZi7YYSj8Pxwns7lr/2w2+NFvrUaZWn+jxmDwgQHEUl8GlXZkIzXu1hdcjUbmjupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggBPTv3eqPWQgUEfpSO8CuvQkPHx+VmKp1TFuUd34rw=;
 b=iBBd3MzbUK6T7ifouWpBJ3CJxDvUFaz6s/cM+vycWPIght+nDvnHQV73YF5DkgaqH/cgT4SQR0YtPrhR2t0N+LJ7aG96kBSQNRxY7e0qGWZ7os4U5u3bJTB9zduwTxb4Y+S6D2YzEvZlO2SOXxrbHrRASCl1A+Sfk1FEJ4Ty0W/08E6oqVRfz8MPTZs3+xZfHjGYMdyftgp94BbshGKD7zaudkU5AFDjag/+OMyRtQ1fc2QX4lzTX7stHlqn3Ov4EskZY8VnYAKNteNiCZW1x54g/zIfVyWyo5ioKuwX2Ql4W0DcON4e/c052e/ZTW0np5diuvGo6ymlRY1m1irO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggBPTv3eqPWQgUEfpSO8CuvQkPHx+VmKp1TFuUd34rw=;
 b=jxYJUeVaUT3O129QLJcISdxJHT/7rvCj7PQ7NrWU+Nt4cll3R9L/8dJjRVqUy5Z6zo93zOpRHCfDaL7dL7MTY/glCF9ih+jDfwTF6lgAidMh1zxgUWy8UzWu/0gyJCWWFoWmMA7+VC6TqCqpc3OWbU+7xhkfskIjpPjTQH/ukMk=
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2793.eurprd07.prod.outlook.com (2603:10a6:3:99::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.15; Wed, 28 Oct 2020 07:36:32 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::eca3:4085:434:e74%6]) with mapi id 15.20.3499.015; Wed, 28 Oct 2020
 07:36:32 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "shuah@kernel.org" <shuah@kernel.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: intel_pstate: ftime() is deprecated
Thread-Topic: [PATCH] selftests: intel_pstate: ftime() is deprecated
Thread-Index: AQHWo7+GrW4fp0iZN0eO7f/RAP0xKKmr8mMAgADAOYA=
Date:   Wed, 28 Oct 2020 07:36:32 +0000
Message-ID: <d4adb97b3325ac93295d5e42dc07e8381fb9efab.camel@nokia.com>
References: <20201016132245.73378-1-tommi.t.rantala@nokia.com>
         <d315994a-3398-be41-1b26-e78f8359aa5c@linuxfoundation.org>
In-Reply-To: <d315994a-3398-be41-1b26-e78f8359aa5c@linuxfoundation.org>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nokia.com;
x-originating-ip: [131.228.2.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 468d14f2-7511-4305-cf36-08d87b143141
x-ms-traffictypediagnostic: HE1PR0701MB2793:
x-microsoft-antispam-prvs: <HE1PR0701MB27936599F14D38A76B94B223B4170@HE1PR0701MB2793.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHI9b0GIbR5ObhL4k6b5snWXNCKohgVrwMXVP3efbRTUOtc/qXDzXJ/3bmSpwP5GVCNSipYB6ayNoZr9RiA9M+YBRZvPkJ3TAw3iFuACVWOtCw4EQsKs2B2mTcwNeavpaeVlbsh+zs7RMbdCKQdPHHdjor6rvlB+yr9OgBVu7zWihBL/CKykhk/wOaDTcoVRjxaBCKRPJ6cjzlL3+gGjiuYaY2IzIoIj52FXIV2gBcIgU2P+Q3qT7Jlqh9khtiGvRKilMoWYxMEgy9YLprkpNqO+4y3B0oABncRpiTtIiYqjIwXCfEfJNtM5oT+VhFGr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(66476007)(2616005)(8676002)(66446008)(5660300002)(26005)(2906002)(76116006)(36756003)(86362001)(66946007)(6506007)(478600001)(64756008)(66556008)(4744005)(110136005)(8936002)(4001150100001)(186003)(316002)(6512007)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: puk8pElpPJni58LTEv9+m77v2ZfpQpwcStTKJ0WqNXTiSqLP/4jhqGs+zy4HGu9ouiomh2Fel9psSU9RRUjZgurKYwSV4bSvmj9GTR/lN3OUujL7JZYP8Z/1RkBCRaroQy7Zf2kbhGrm55gfOD4qQPzDyXSqg+DRhuDStR0WgQwZQE1ftFiWeV5r/0yJIRgAo6V6AuSuJ2QF2nwu0gNyFAFuEl0ohupK0QaDAjioLjStmQAutx47rpGCu2VIjIhGiDpK96nuRCUUtNlcUzGFGatVsXiISL6lioNiyMNZ7eXntl0d6KB5zTgEbJmbx2lobpEZlXJOaS34U0HYFwLObxreadi1VpNrY9LaitbK+2rDsvMp1h9jj9GHxcTRZBF87RTnZ3cMAbBKapaYiKaarF8+qynXjk/ygQbr8lvofT9QMOVDATRNRis04rSS+E/EXCdRNNZV7sFfvkXp684ypO8UZJMG0uFRQW0jx9xxFvsl4VvY5sWbHVkjo3Vc6JBaXjUIJ1/b22q6/MAJoyHsdDkUo+FeY3T3Zp0moFUYfvF/WDv8aHz7B7zeKS2WNRkDNujzsELu5Sd20fnG80Mq/dcMm9cBWrqwPJW+6XrCF7Rd5I5/JWvdt0fiOrTTuLEArcS3xANpKsCS0WTy3fimdg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <324B20705E37B7408C84C8A13A60B959@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468d14f2-7511-4305-cf36-08d87b143141
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 07:36:32.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgc6wldo9/Uab8KZD7pqtb0b4vUQ1accN8vkIryXbgZa8l9pR8Uur2MyjOmJBJXB9soBqP2eyoJ0A1A9Rd8gXoSxoJ/j9Mc4kNoFIPUdozw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2793
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDE0OjA4IC0wNjAwLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiAN
Cj4gPiBAQCAtNzMsOCArODAsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsN
Cj4gPiAgIAlhcGVyZiA9IG5ld19hcGVyZi1vbGRfYXBlcmY7DQo+ID4gICAJbXBlcmYgPSBuZXdf
bXBlcmYtb2xkX21wZXJmOw0KPiA+ICAgDQo+ID4gLQlzdGFydCA9IGJlZm9yZS50aW1lKjEwMDAg
KyBiZWZvcmUubWlsbGl0bTsNCj4gPiAtCWZpbmlzaCA9IGFmdGVyLnRpbWUqMTAwMCArIGFmdGVy
Lm1pbGxpdG07DQo+ID4gKwlzdGFydCA9IGJlZm9yZS50dl9zZWMqMTAwMCArIGJlZm9yZS50dl9u
c2VjLzEwMDAwMDBMOw0KPiA+ICsJZmluaXNoID0gYWZ0ZXIudHZfc2VjKjEwMDAgKyBhZnRlci50
dl9uc2VjLzEwMDAwMDBMOw0KPiANCj4gV2h5IG5vdCB1c2UgdGltZXNwZWMgZE5TRUNfUEVSX01T
RUMgZGVmaW5lIGZyb20gIGluY2x1ZGUvdmRzby90aW1lNjQuaD8NCg0KSGksDQoNCklmIHRoZSBk
ZWZpbmUgd2FzIGF2YWlsYWJsZSBpbiB0aGUgVUFQSSBoZWFkZXJzLCB0aGVuIGNlcnRhaW5seSB3
b3VsZCBtYWtlDQpzZW5zZSB0byB1c2UgaXQuIEJ1dCBJIHdvdWxkIG5vdCBtZXNzIHdpdGggdGhl
IGtlcm5lbCBpbnRlcm5hbCBoZWFkZXJzIGhlcmUuDQoNCi1Ub21taQ0KDQo=
