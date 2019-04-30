Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C716CFF41
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfD3SDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 14:03:22 -0400
Received: from mail-eopbgr820089.outbound.protection.outlook.com ([40.107.82.89]:32704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfD3SDW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 14:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcTyGKK7XhXuFlLZ+UH/eXQ5TFTAt7g8+oy6gIRtKFQ=;
 b=oNtSCIixWsWFKmT4my1wLctp2ecLcn+Xi1t5G2bZopIM9pLUH4DwEIicx1StftMWWmJ16CTIM3zOEbleFTQ9CBcLKTgq8WLkbDV/HSm5Fs5pVPghjgml4haiKdm3igSrC9k0QtXGI8lYDlYiTp9vgA5PWVIJ+vzzbQXQ0yp0QVc=
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (20.179.92.82) by
 BYAPR12MB3494.namprd12.prod.outlook.com (20.178.196.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Tue, 30 Apr 2019 18:03:12 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::9118:73f2:809c:22c7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::9118:73f2:809c:22c7%4]) with mapi id 15.20.1835.010; Tue, 30 Apr 2019
 18:03:12 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Kuehling@google.com" <Kuehling@google.com>,
        "Deucher@google.com" <Deucher@google.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig@google.com" <Koenig@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v14 11/17] drm/amdgpu, arm64: untag user pointers
Thread-Topic: [PATCH v14 11/17] drm/amdgpu, arm64: untag user pointers
Thread-Index: AQHU/1g9Os+vw7iTBUyHAg3XuguIT6ZU/zsA
Date:   Tue, 30 Apr 2019 18:03:12 +0000
Message-ID: <3108d33e-8e18-a73e-5e1a-f0db64f02ab3@amd.com>
References: <cover.1556630205.git.andreyknvl@google.com>
 <2e827b5c484be14044933049fec180cd6acb054b.1556630205.git.andreyknvl@google.com>
In-Reply-To: <2e827b5c484be14044933049fec180cd6acb054b.1556630205.git.andreyknvl@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-clientproxiedby: YQXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:133::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c0999f5-fea3-44c9-0853-08d6cd961c3f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3494;
x-ms-traffictypediagnostic: BYAPR12MB3494:
x-microsoft-antispam-prvs: <BYAPR12MB34944A9CF5D1F8C6996BDC3E923A0@BYAPR12MB3494.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(6486002)(99286004)(31686004)(25786009)(52116002)(66066001)(11346002)(65956001)(65806001)(446003)(68736007)(316002)(476003)(2616005)(3846002)(110136005)(486006)(186003)(6116002)(305945005)(58126008)(7736002)(72206003)(14454004)(54906003)(478600001)(4326008)(97736004)(6246003)(7416002)(7406005)(6506007)(36756003)(386003)(53546011)(8676002)(102836004)(2501003)(26005)(5660300002)(53936002)(6436002)(6512007)(8936002)(65826007)(81166006)(81156014)(64126003)(229853002)(66946007)(2201001)(73956011)(71200400001)(71190400001)(66476007)(66446008)(64756008)(66556008)(86362001)(76176011)(256004)(31696002)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3494;H:BYAPR12MB3176.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nO9DaGDv6+2lX6EAW/xC3yZdEwR1SwyhpeYY2JKG8pN4EFtG0GW/j6cJ/QaUHEiswwrMSPxcJEO63sn7llbzLacEK8Vy44iqfEae7En0ty2SKV0vxUvuUnDs5qJ+2X5q2XmhjycRmXknWwSxV/y6PVYAO+c8lanTWxlluHWFDePvqBrfB7u2EpAawDQYbKsS8q/7sHqUolAn/F5oyCXH/XlTa3vppoAb+w+sgCaGxC/Gw2CppEFaGT14LNJGXSDrmaE+Usqh8RWTSfk6/zkAfCIt5QOD4cX5JF93WPUJf1+9sH+pFC+Fnc2DBNH75lW/5BtAmfwfOX1vmscn2aMtreJqaPk7SVO9mzCmPK3tNiWaTTFrbGGemYuncAx88RIY1e8Aog2mKb3jOyvDhbCPHII4FkaR2q6WDizpkz+ZcoY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C547763D046D774F9BA7C517CFFB0B87@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0999f5-fea3-44c9-0853-08d6cd961c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 18:03:12.6688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gMjAxOS0wNC0zMCA5OjI1IGEubS4sIEFuZHJleSBLb25vdmFsb3Ygd3JvdGU6DQo+IFtDQVVU
SU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4NCj4gVGhpcyBwYXRjaCBpcyBhIHBhcnQgb2YgYSBzZXJp
ZXMgdGhhdCBleHRlbmRzIGFybTY0IGtlcm5lbCBBQkkgdG8gYWxsb3cgdG8NCj4gcGFzcyB0YWdn
ZWQgdXNlciBwb2ludGVycyAod2l0aCB0aGUgdG9wIGJ5dGUgc2V0IHRvIHNvbWV0aGluZyBlbHNl
IG90aGVyDQo+IHRoYW4gMHgwMCkgYXMgc3lzY2FsbCBhcmd1bWVudHMuDQo+DQo+IGFtZGdwdV90
dG1fdHRfZ2V0X3VzZXJfcGFnZXMoKSB1c2VzIHByb3ZpZGVkIHVzZXIgcG9pbnRlcnMgZm9yIHZt
YQ0KPiBsb29rdXBzLCB3aGljaCBjYW4gb25seSBieSBkb25lIHdpdGggdW50YWdnZWQgcG9pbnRl
cnMuIFRoaXMgcGF0Y2gNCj4gdW50YWcgdXNlciBwb2ludGVycyB3aGVuIHRoZXkgYXJlIGJlaW5n
IHNldCBpbg0KPiBhbWRncHVfdHRtX3R0X3NldF91c2VycHRyKCkuDQo+DQo+IEluIGFtZGdwdV9n
ZW1fdXNlcnB0cl9pb2N0bCgpIGFuZCBhbWRncHVfYW1ka2ZkX2dwdXZtLmMvaW5pdF91c2VyX3Bh
Z2VzKCkNCj4gYW4gTU1VIG5vdGlmaWVyIGlzIHNldCB1cCB3aXRoIGEgKHRhZ2dlZCkgdXNlcnNw
YWNlIHBvaW50ZXIuIFRoZSB1bnRhZ2dlZA0KPiBhZGRyZXNzIHNob3VsZCBiZSB1c2VkIHNvIHRo
YXQgTU1VIG5vdGlmaWVycyBmb3IgdGhlIHVudGFnZ2VkIGFkZHJlc3MgZ2V0DQo+IGNvcnJlY3Rs
eSBtYXRjaGVkIHVwIHdpdGggdGhlIHJpZ2h0IEJPLiBUaGlzIHBhdGNoIHVudGFnIHVzZXIgcG9p
bnRlcnMgaW4NCj4gYW1kZ3B1X2dlbV91c2VycHRyX2lvY3RsKCkgZm9yIHRoZSBHRU0gY2FzZSBh
bmQgaW4NCj4gYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KCkgZm9yIHRo
ZSBLRkQgY2FzZS4NCj4NCj4gU3VnZ2VzdGVkLWJ5OiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJl
eWtudmxAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYyAgICAgICAgICB8IDIgKysNCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMgICAgICAgICAgfCAyICstDQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gaW5kZXggMTkyMWRlYzNk
ZjdhLi4yMGNhYzQ0ZWQ0NDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gQEAgLTExMjEsNyArMTEyMSw3IEBAIGludCBh
bWRncHVfYW1ka2ZkX2dwdXZtX2FsbG9jX21lbW9yeV9vZl9ncHUoDQo+ICAgICAgICAgICAgICAg
ICAgYWxsb2NfZmxhZ3MgPSAwOw0KPiAgICAgICAgICAgICAgICAgIGlmICghb2Zmc2V0IHx8ICEq
b2Zmc2V0KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IC0g
ICAgICAgICAgICAgICB1c2VyX2FkZHIgPSAqb2Zmc2V0Ow0KPiArICAgICAgICAgICAgICAgdXNl
cl9hZGRyID0gdW50YWdnZWRfYWRkcigqb2Zmc2V0KTsNCj4gICAgICAgICAgfSBlbHNlIGlmIChm
bGFncyAmIEFMTE9DX01FTV9GTEFHU19ET09SQkVMTCkgew0KPiAgICAgICAgICAgICAgICAgIGRv
bWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsNCj4gICAgICAgICAgICAgICAgICBhbGxvY19k
b21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9DUFU7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMNCj4gaW5kZXggZDIxZGQyZjM2OWRhLi45ODVjYjgyYjJhYTYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gQEAgLTI4Niw2ICsy
ODYsOCBAQCBpbnQgYW1kZ3B1X2dlbV91c2VycHRyX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHZvaWQgKmRhdGEsDQo+ICAgICAgICAgIHVpbnQzMl90IGhhbmRsZTsNCj4gICAgICAgICAg
aW50IHI7DQo+DQo+ICsgICAgICAgYXJncy0+YWRkciA9IHVudGFnZ2VkX2FkZHIoYXJncy0+YWRk
cik7DQo+ICsNCj4gICAgICAgICAgaWYgKG9mZnNldF9pbl9wYWdlKGFyZ3MtPmFkZHIgfCBhcmdz
LT5zaXplKSkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYw0KPiBpbmRleCA3M2U3MWU2MWRjOTkuLjFk
MzBlOTdhYzJjNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Yw0KPiBAQCAtMTI0OCw3ICsxMjQ4LDcgQEAgaW50IGFtZGdwdV90dG1fdHRfc2V0X3VzZXJwdHIo
c3RydWN0IHR0bV90dCAqdHRtLCB1aW50NjRfdCBhZGRyLA0KPiAgICAgICAgICBpZiAoZ3R0ID09
IE5VTEwpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+IC0gICAgICAg
Z3R0LT51c2VycHRyID0gYWRkcjsNCj4gKyAgICAgICBndHQtPnVzZXJwdHIgPSB1bnRhZ2dlZF9h
ZGRyKGFkZHIpOw0KDQpEb2luZyB0aGlzIGhlcmUgc2VlbXMgdW5uZWNlc3NhcnkuIFlvdSBhbHJl
YWR5IHVudGFnZ2VkIHRoZSBhZGRyZXNzIGluIA0KYm90aCBjYWxsZXJzIG9mIHRoaXMgZnVuY3Rp
b24uIFVudGFnZ2luZyBpbiB0aGUgdHdvIGNhbGxlcnMgZW5zdXJlcyB0aGF0IA0KdGhlIHVzZXJw
dHIgYW5kIE1NVSBub3RpZmllciBhcmUgaW4gc3luYywgdXNpbmcgdGhlIHNhbWUgdW50YWdnZWQg
DQphZGRyZXNzLiBEb2luZyBpdCBhZ2FpbiBoZXJlIGlzIHJlZHVuZGFudC4NCg0KUmVnYXJkcywN
CiDCoCBGZWxpeA0KDQoNCj4gICAgICAgICAgZ3R0LT51c2VyZmxhZ3MgPSBmbGFnczsNCj4NCj4g
ICAgICAgICAgaWYgKGd0dC0+dXNlcnRhc2spDQo+IC0tDQo+IDIuMjEuMC41OTMuZzUxMWVjMzQ1
ZTE4LWdvb2cNCj4NCg==
