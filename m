Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAE16835
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 18:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEGQoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 May 2019 12:44:08 -0400
Received: from mail-eopbgr730065.outbound.protection.outlook.com ([40.107.73.65]:13792
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfEGQoH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 May 2019 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDmUxc0I3Vs06iUOv0mgYhYfmxdHxaW2JnGAm6xmlv4=;
 b=Uo8Nv1i3+69R/LhIxA3soBtXJ2s46HvlJdQoCtBNkfjEGnuoOXrCeXEd+f+FmlnJA0QmasVRB7BYDnk2uCZy86IWpuo418YVAzko+51ZBkfaRJKMicVW0XR7xHG8dD8Ngc8gbJnMxuTKKQmrt3wxM4zHz376fEGgZ9IuvR64H8E=
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (20.179.92.82) by
 BYAPR12MB3544.namprd12.prod.outlook.com (20.179.94.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 16:44:02 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::9118:73f2:809c:22c7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::9118:73f2:809c:22c7%4]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 16:44:02 +0000
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
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
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
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 12/17] drm/radeon, arm64: untag user pointers in
 radeon_gem_userptr_ioctl
Thread-Topic: [PATCH v15 12/17] drm/radeon, arm64: untag user pointers in
 radeon_gem_userptr_ioctl
Thread-Index: AQHVBCkzLfkJvfOc9kqyclyg05ajP6Zf386A
Date:   Tue, 7 May 2019 16:44:02 +0000
Message-ID: <7568118b-ad57-156c-464f-54fb3f90a783@amd.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <03fe9d923db75cf72678f3ce103838e67390751a.1557160186.git.andreyknvl@google.com>
In-Reply-To: <03fe9d923db75cf72678f3ce103838e67390751a.1557160186.git.andreyknvl@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-clientproxiedby: YTXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::35) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:133::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93eca1e0-2a8f-45ef-5051-08d6d30b35d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3544;
x-ms-traffictypediagnostic: BYAPR12MB3544:
x-microsoft-antispam-prvs: <BYAPR12MB35449D43230F5246FFBE6D1892310@BYAPR12MB3544.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(72206003)(71190400001)(2501003)(316002)(76176011)(386003)(36756003)(81166006)(53546011)(66066001)(476003)(81156014)(6506007)(14454004)(8936002)(478600001)(52116002)(102836004)(486006)(2906002)(8676002)(65956001)(31696002)(65806001)(68736007)(25786009)(5660300002)(186003)(2616005)(6116002)(6246003)(66446008)(73956011)(11346002)(86362001)(446003)(66476007)(64756008)(2201001)(66946007)(26005)(4326008)(31686004)(71200400001)(6512007)(66556008)(53936002)(229853002)(64126003)(58126008)(54906003)(305945005)(6486002)(7406005)(7416002)(256004)(99286004)(65826007)(7736002)(110136005)(6436002)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3544;H:BYAPR12MB3176.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lq5pCPDcPNLU5X+6HbKKo8uqlLH+qh1zPjC6a8jGCekQNZW/q3Uz5M5mILQQpOHPKm6yY7nVRSZkwb1aqbixPMKXDgRTrUEtSJc3P0fPdeVOAWwqkgoD6CXrw1+YnroUVESXWCnoWejM1WWWmtHHXP/3jLhJBO+0owXMBvH5Zjj7+nHCSozrJ++KKAP4ZRiPdoDmJVdEjPv4cM/2d8TBRHXO/Qd6GZcvYkcHUd1Nd9wYO+vrqFTuHiSZXQIUA+091XhYfn/pTZ5FbYAGZQFJZGCdA4KlegQuZPs2ughkxoW92Z9qq4w/pVD1i2tJKBOKsXs+vssL9Jfc4LWT0XHg5u6nA1YN4UpzQZ4b7EHBx37e00LlGJc2ZkMXVBMWO3RFqCccp5ZFyrsn9YtusagfI81mN78mXr3VKrVHTnKLwGY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC55AB809D9E174784D2867A22094BC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eca1e0-2a8f-45ef-5051-08d6d30b35d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 16:44:02.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3544
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gMjAxOS0wNS0wNiAxMjozMCBwLm0uLCBBbmRyZXkgS29ub3ZhbG92IHdyb3RlOg0KPiBbQ0FV
VElPTjogRXh0ZXJuYWwgRW1haWxdDQo+DQo+IFRoaXMgcGF0Y2ggaXMgYSBwYXJ0IG9mIGEgc2Vy
aWVzIHRoYXQgZXh0ZW5kcyBhcm02NCBrZXJuZWwgQUJJIHRvIGFsbG93IHRvDQo+IHBhc3MgdGFn
Z2VkIHVzZXIgcG9pbnRlcnMgKHdpdGggdGhlIHRvcCBieXRlIHNldCB0byBzb21ldGhpbmcgZWxz
ZSBvdGhlcg0KPiB0aGFuIDB4MDApIGFzIHN5c2NhbGwgYXJndW1lbnRzLg0KPg0KPiBJbiByYWRl
b25fZ2VtX3VzZXJwdHJfaW9jdGwoKSBhbiBNTVUgbm90aWZpZXIgaXMgc2V0IHVwIHdpdGggYSAo
dGFnZ2VkKQ0KPiB1c2Vyc3BhY2UgcG9pbnRlci4gVGhlIHVudGFnZ2VkIGFkZHJlc3Mgc2hvdWxk
IGJlIHVzZWQgc28gdGhhdCBNTVUNCj4gbm90aWZpZXJzIGZvciB0aGUgdW50YWdnZWQgYWRkcmVz
cyBnZXQgY29ycmVjdGx5IG1hdGNoZWQgdXAgd2l0aCB0aGUgcmlnaHQNCj4gQk8uIFRoaXMgZnVu
Y2F0aW9uIGFsc28gY2FsbHMgcmFkZW9uX3R0bV90dF9waW5fdXNlcnB0cigpLCB3aGljaCB1c2Vz
DQo+IHByb3ZpZGVkIHVzZXIgcG9pbnRlcnMgZm9yIHZtYSBsb29rdXBzLCB3aGljaCBjYW4gb25s
eSBieSBkb25lIHdpdGgNCj4gdW50YWdnZWQgcG9pbnRlcnMuDQo+DQo+IFRoaXMgcGF0Y2ggdW50
YWdzIHVzZXIgcG9pbnRlcnMgaW4gcmFkZW9uX2dlbV91c2VycHRyX2lvY3RsKCkuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IEFuZHJleSBLb25vdmFsb3YgPGFuZHJleWtudmxAZ29vZ2xlLmNvbT4NCkFj
a2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCg0KDQo+IC0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5jIHwgMiArKw0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZ2VtLmMNCj4gaW5kZXggNDQ2MTdkZWM4MTgzLi45MGViNzhmYjVlYjIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5jDQo+IEBAIC0yOTEsNiArMjkxLDggQEAgaW50IHJh
ZGVvbl9nZW1fdXNlcnB0cl9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRh
LA0KPiAgICAgICAgICB1aW50MzJfdCBoYW5kbGU7DQo+ICAgICAgICAgIGludCByOw0KPg0KPiAr
ICAgICAgIGFyZ3MtPmFkZHIgPSB1bnRhZ2dlZF9hZGRyKGFyZ3MtPmFkZHIpOw0KPiArDQo+ICAg
ICAgICAgIGlmIChvZmZzZXRfaW5fcGFnZShhcmdzLT5hZGRyIHwgYXJncy0+c2l6ZSkpDQo+ICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+IC0tDQo+IDIuMjEuMC4xMDIwLmdm
MjgyMGNmMDFhLWdvb2cNCj4NCg==
