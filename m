Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E964B38FD09
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhEYIok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 04:44:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:51742 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhEYIok (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 04:44:40 -0400
IronPort-SDR: a7/d8FUDVkd1MtduYcIkmDy6zIcJsMOg6Z6lUOjgY1nEO8WoUyXKv3oym3waVzM4FXDSox5EBa
 no5EiUDQ/x7g==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="223306480"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="223306480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 01:43:10 -0700
IronPort-SDR: 4MQZACW0Lt5lg00s/B20NSuk1yL0JkezDBXZz0BBbAXs1WKdICW4R29Ox4uZoUQIlBbQo61z1o
 qIHIAydEjOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="546485004"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 25 May 2021 01:43:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 25 May 2021 01:43:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 25 May 2021 01:43:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 25 May 2021 01:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4ekcMTARX28L9VKTk5uoK0cOqHe1Y0CyM7s6cLJQdS6qH41TQOyDXhyN/luNsAMGnxQOx5be2GAprCM2QWL7xKjNMhNKmSlxme9aj3vDcVL4Gx8/Zho63DN9+ns5OToxg4Bhgyy8ug2k2mfqZAhnAA4u4jRAss+pwXhlBqDYL+wVlHSUbKdS6aRlE7SxL0nRO5jExxNdcxsdQHmx4KKYSognaON71sinAhr1ymJsDgYITGqgZb6ogst+Pje1YzEaWvGScnYoPFaHDsTH7TMoE88dVZEqcbGTKZuBrkOI//LIYCMtV2NVBeXo+r/sHI22MpGR9H61+wplUuJykFzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFigB8bX2cUQpzNiVRw4Gq9UC8VMd0VpTtrbU4Kc/fQ=;
 b=SG+Q7Lcxp1FgX8UDQ73ckfYlvzHop9kYgSrdBFVd8czfA2n/Bn9OLFoRmAGgM8O9HqsjaEIqL7GtHjcQ4QCYk/bO1/BxfasAssp5C+aj6a2fbtLm7SEkX7CgLxc2ZkR0PvLrCm8ETFBuBF1Zkjo0DWHk/9vGqAwt7k4n8WbF4LYjun46af4x68ZDQoP7knc7lDSgCqachMdnBgzk8Kf0FnJlPC7fpzeV0uSDIIsNs47TMhQqwh+6JIdla+pAdTSzdp0b0HibAZlKROxuS14UZi2DLf1rR9v00c8oGaODZHVyod4PbUCHDDkaC0MSFtrlcawfwMB+HS9sqO/eBxOahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFigB8bX2cUQpzNiVRw4Gq9UC8VMd0VpTtrbU4Kc/fQ=;
 b=smRpMy0Q45iWz1OLWuLv4IDd92emidmY+fZd8E7cSRu0TD2F5hOk+2zvJgIB2XaylRoH1OfHegv4It51aFFKtUXX2goPaIoaUCh5Vimw0fBTt7da+eudLCrN61Ah7/mfe8bHR0JBGIg4O4SU53xe/n4gVU/ay5kbMcUJBBLaK8w=
Received: from DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) by
 DM8PR11MB5639.namprd11.prod.outlook.com (2603:10b6:8:24::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Tue, 25 May 2021 08:43:08 +0000
Received: from DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::ccbb:37d7:aba8:2f8e]) by DM8PR11MB5670.namprd11.prod.outlook.com
 ([fe80::ccbb:37d7:aba8:2f8e%8]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 08:43:08 +0000
From:   "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: RE: [PATCH] selftests: kvm: Fix a potential elf loading issue
Thread-Topic: [PATCH] selftests: kvm: Fix a potential elf loading issue
Thread-Index: AQHXRmF05PtyWFMmVEOiqNWnCg92Fqryo60AgAFSt1A=
Date:   Tue, 25 May 2021 08:43:07 +0000
Message-ID: <DM8PR11MB5670F958184509909A1876B892259@DM8PR11MB5670.namprd11.prod.outlook.com>
References: <20210512043107.30076-1-zhenzhong.duan@intel.com>
 <20210512043107.30076-2-zhenzhong.duan@intel.com>
 <2b16869a-7518-529b-9cbe-fb2e5f61a6e9@redhat.com>
In-Reply-To: <2b16869a-7518-529b-9cbe-fb2e5f61a6e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [114.246.35.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9323a178-63e1-4ac9-3d8a-08d91f591ef2
x-ms-traffictypediagnostic: DM8PR11MB5639:
x-microsoft-antispam-prvs: <DM8PR11MB563984029D5B6B655D43C50A92259@DM8PR11MB5639.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISjap+Xx+emmW10QkyGua/5ALG9+FHGdygitgkmk3tFxHJbgL3ZFDgDgxYG1/bgP3dTTgMsXJOTCjpusygjpb3w3yHTgbtK8tjdQNW6uqXkTZXHnyjA0alK0ms8VvnI1gD0+Ed+o3GziGuJ7y8dNCVzaqAk/x+SG6gtB8NQ/2i7/etA8wmBUw/RqLTC4PEGbmXdzDQzCxApCVYKy1Iz3a5R+S2MUXDYZQuE4mIAw7/l1FFObzO8VWknzESCVZjRLY1x4yrtRF9S7DL+sXmDOOKdo9Tn/U4xMNrQ6AsjWCedZSvpS8s1iC3nNVtqwGqL7BXn971MqaBLKPEnHykvECSuFb6WqyF+By63rwjWI6ZnHiuMPSBOL/HsKKC1vJ6K1D296Dg1YX3nBgdDPB4EKPNKq6p8UDhUDyIWwM1q6tCkBBWsIQjbYv8liOOReQii/J+p+Nu6pynnudv5WvItK7vzjRNxAvaRCelZ1AW5uqjSbcEvmq2akqCEeLAwdA+O2wZLYTtKvRBlK1RkDMNwrzR2MGhDucAI1kGc/+C9gntb5sjSUvo+qFcbZ5I2GP+9jKfkejcNWCsCN+rzAjxnS2SdDR63lhnIb2VAq9hW0xb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5670.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39860400002)(136003)(346002)(38100700002)(26005)(5660300002)(122000001)(8676002)(33656002)(86362001)(53546011)(8936002)(4326008)(7696005)(55016002)(186003)(9686003)(110136005)(83380400001)(54906003)(64756008)(66556008)(66476007)(66946007)(316002)(66446008)(76116006)(2906002)(478600001)(52536014)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H3M5tKgj6HEzXpMaQCbxhivFWjEqOzFsHIz2iuZxIiqo2cChNzZ+GjORVSYwHeT+jxtDLYQLKQNNfw6HHPVFTQcVBy5nPvLHzekbNJUZ6vrECEnVzfodbzVJPeSGt9SwiU2MpVYCTyYC6hOqh9AxNUvwzij0nbPEJPw90pbZqY0aIXwUxmkO4Ki3KRXlTR5kO2u/QvymXrHp+Yj3Z4dXp+Yuf+zSfzeRzkoU75AxI4lrd7c24vfch0iD7P5zXvN7jyUuf22jaAmoGKxcEY5UjIuxfWclNwyo6yU3iKVL0FW/V9bMxipYCZV3p6q352TGSpjV0MjkAikDc205rVpMfxYS7rg4pv9GgVRzOQXi4gIKpjZ8DIkY+VZUYCunKVCKQs0QzESb06PfUPv9wJTdUq8KSQIGz7F+scOHIQXM+awi5++UNb8zv6x/nzl+qKqGV/ZFNOuIeYu1K0l7Rypm6ErEq3yN7GDpTcgzLmXxFkOaMMASpDWC/p7S07zndS6eKi3I1UxZc5LajEV9Ds7TckikLiCgJvBawIr9PtziGhdVpKKp8yAljcehgLcrLtBw0w0PcRMr2/3sygvpoQ5xuKEr0+OKm+q8wBRvNr2cyo61sILYyT90aWgr/ftRxD7122VK9MnEACycHn1bYvwD8CXf9MrkqWaheaw9giiv5uD2Kd3/xr/iR0Juw15w7CG9eUYaiTWrBrLVaqcpAZiV2xE4Ngr2MEHpQYLMXW+U/WU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5670.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9323a178-63e1-4ac9-3d8a-08d91f591ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 08:43:08.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2F1XyT6XBSCAJrhvqQbgMdikt6n+eSh0wjF36yUK88ml4BxBl6Rq2Wv+X/iYHroSnFFOzy/ZC0ooao5jLZ57eQdum4LXi2qs1DEoajexwkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5639
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgPHBi
b256aW5pQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWF5IDI0LCAyMDIxIDg6MjggUE0N
Cj4gVG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtl
cm5lbC5vcmc7IGt2bUB2Z2VyLmtlcm5lbC5vcmc7IHNodWFoQGtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gc2VsZnRlc3RzOiBrdm06IEZpeCBhIHBvdGVudGlhbCBlbGYgbG9hZGlu
ZyBpc3N1ZQ0KPiANCj4gT24gMTIvMDUvMjEgMDY6MzEsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
PiA+IHZtX3ZhZGRyX2FsbG9jKCkgc2V0dXAgR1ZBIHRvIEdQQSBtYXBwaW5nIHBhZ2UgYnkgcGFn
ZSwgdGhlbiBHUEEgbWF5DQo+ID4gbm90IGJlIGNvbnRpbnVvdXMgaWYgc2FtZSBtZW1zbG90IGlz
IHVzZWQgZm9yIGRhdGEgYW5kIHBhZ2UgdGFibGUNCj4gYWxsb2NhdGlvbi4NCj4gPg0KPiA+IGt2
bV92bV9lbGZfbG9hZCgpIGV4cGVjdHMgYSBjb250aW51b3VzIG1lbW9yeSBvZiBHUEEgb3IgZWxz
ZSBpdCBuZWVkDQo+ID4gdG8gcmVhZCBmaWxlIGRhdGEgcGFnZSBieSBwYWdlLiBGaXggaXQgYnkg
YWRkaW5nIGEgY2hlY2sgaW4NCj4gPiB2bV92YWRkcl9hbGxvYygpIHRvIGVuc3VyZSBtZW1vcnkg
aXMgYWxsb2NhdGVkIGluIGEgd2hvbGUgaWYgc2FtZQ0KPiA+IG1lbXNsb3QgaXMgdXNlZCBmb3Ig
ZGF0YSBhbmQgcGFnZSB0YWJsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+ID4gLS0tDQo+IFdoeSBub3QgZG8NCj4g
DQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL2t2bV91dGls
LmMNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL2t2bV91dGlsLmMNCj4gaW5k
ZXggNzQyNjE2M2Q0NDhhLi5mMzYyYTA2NmYzN2EgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2t2bS9saWIva3ZtX3V0aWwuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9rdm0vbGliL2t2bV91dGlsLmMNCj4gQEAgLTExNzAsNiArMTE3MCw5IEBAIHZtX3Zh
ZGRyX3Qgdm1fdmFkZHJfYWxsb2Moc3RydWN0IGt2bV92bSAqdm0sDQo+IHNpemVfdCBzeiwgdm1f
dmFkZHJfdCB2YWRkcl9taW4sDQo+ICAgCXVpbnQ2NF90IHBhZ2VzID0gKHN6ID4+IHZtLT5wYWdl
X3NoaWZ0KSArICgoc3ogJSB2bS0+cGFnZV9zaXplKSAhPSAwKTsNCj4gDQo+ICAgCXZpcnRfcGdk
X2FsbG9jKHZtLCBwZ2RfbWVtc2xvdCk7DQo+ICsJdm1fcGFkZHJfdCBwYWRkciA9IHZtX3BoeV9w
YWdlc19hbGxvYyh2bSwgcGFnZXMsDQo+ICsJCQkJCSAgICAgIEtWTV9VVElMX01JTl9QRk4gKiB2
bS0NCj4gPnBhZ2Vfc2l6ZSwNCj4gKwkJCQkJICAgICAgZGF0YV9tZW1zbG90KTsNCj4gDQo+ICAg
CS8qDQo+ICAgCSAqIEZpbmQgYW4gdW51c2VkIHJhbmdlIG9mIHZpcnR1YWwgcGFnZSBhZGRyZXNz
ZXMgb2YgYXQgbGVhc3QgQEAgLQ0KPiAxMTc5LDExICsxMTgyLDcgQEAgdm1fdmFkZHJfdCB2bV92
YWRkcl9hbGxvYyhzdHJ1Y3Qga3ZtX3ZtICp2bSwNCj4gc2l6ZV90IHN6LCB2bV92YWRkcl90IHZh
ZGRyX21pbiwNCj4gDQo+ICAgCS8qIE1hcCB0aGUgdmlydHVhbCBwYWdlcy4gKi8NCj4gICAJZm9y
ICh2bV92YWRkcl90IHZhZGRyID0gdmFkZHJfc3RhcnQ7IHBhZ2VzID4gMDsNCj4gLQkJcGFnZXMt
LSwgdmFkZHIgKz0gdm0tPnBhZ2Vfc2l6ZSkgew0KPiAtCQl2bV9wYWRkcl90IHBhZGRyOw0KPiAt
DQo+IC0JCXBhZGRyID0gdm1fcGh5X3BhZ2VfYWxsb2Modm0sDQo+IC0JCQkJS1ZNX1VUSUxfTUlO
X1BGTiAqIHZtLT5wYWdlX3NpemUsDQo+IGRhdGFfbWVtc2xvdCk7DQo+ICsJCXBhZ2VzLS0sIHZh
ZGRyICs9IHZtLT5wYWdlX3NpemUsIHBhZGRyICs9IHZtLT5wYWdlX3NpemUpIHsNCj4gDQo+ICAg
CQl2aXJ0X3BnX21hcCh2bSwgdmFkZHIsIHBhZGRyLCBwZ2RfbWVtc2xvdCk7DQo+IA0KPiANCj4g
aW5zdGVhZD8NCg0KWWVzLCB0aGlzIGlzIGJldHRlciwgdGhhbmtzIGZvciBmaXhpbmcuDQoNClJl
Z2FyZHMNClpoZW56aG9uZw0K
