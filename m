Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEB2AEE01
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 10:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKKJmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 04:42:52 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2060 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKKJms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 04:42:48 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CWKX06cr2zVmv9;
        Wed, 11 Nov 2020 17:42:24 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 11 Nov 2020 17:42:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Wed, 11 Nov 2020 17:42:42 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Garry <john.garry@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        Shuah Khan <shuah@kernel.org>
Subject: RE: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Topic: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWsO+tiT3rvc8AvUKektYgWKvLn6nBDT6Q//+EgQCAAZyYMIAABiqAgACFcyA=
Date:   Wed, 11 Nov 2020 09:42:42 +0000
Message-ID: <fe3cda84536849dea5cc48fe050a1cbe@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
 <0658ee16-d539-61c5-1d39-77d50f559803@huawei.com>
 <88e91063b7f041bda7d147438f1c4621@hisilicon.com>
 <51f0c148-e2e3-e084-4021-ec5883919436@huawei.com>
In-Reply-To: <51f0c148-e2e3-e084-4021-ec5883919436@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.81]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeQ0KPiBT
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDExLCAyMDIwIDEwOjM3IFBNDQo+IFRvOiBTb25nIEJh
byBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47DQo+IGlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBoY2hAbHN0LmRlOyByb2Jpbi5tdXJwaHlAYXJt
LmNvbTsNCj4gbS5zenlwcm93c2tpQHNhbXN1bmcuY29tDQo+IENjOiBsaW51eC1rc2VsZnRlc3RA
dmdlci5rZXJuZWwub3JnOyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgSm9lcmcNCj4g
Um9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47
IHh1d2VpIChPKQ0KPiA8eHV3ZWk1QGh1YXdlaS5jb20+OyBTaHVhaCBLaGFuIDxzaHVhaEBrZXJu
ZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZG1hLW1hcHBpbmc6IGFkZCBi
ZW5jaG1hcmsgc3VwcG9ydCBmb3INCj4gc3RyZWFtaW5nIERNQSBBUElzDQo+IA0KPiBPbiAxMS8x
MS8yMDIwIDAxOjI5LCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIHdyb3RlOg0KPiA+IEknZCBs
aWtlIHRvIHRoaW5rIGNoZWNraW5nIHRoaXMgaGVyZSB3b3VsZCBiZSBvdmVyZGVzaWduLiBXZSBq
dXN0IGdpdmUgdXNlcnMgdGhlDQo+ID4gZnJlZWRvbSB0byBiaW5kIGFueSBkZXZpY2UgdGhleSBj
YXJlIGFib3V0IHRvIHRoZSBiZW5jaG1hcmsgZHJpdmVyLiBVc3VhbGx5DQo+ID4gdGhhdCBtZWFu
cyBhIHJlYWwgaGFyZHdhcmUgZWl0aGVyIGJlaGluZCBhbiBJT01NVSBvciB0aHJvdWdoIGEgZGly
ZWN0DQo+ID4gbWFwcGluZy4NCj4gPg0KPiA+IGlmIGZvciBhbnkgcmVhc29uIHVzZXJzIHB1dCBh
IHdyb25nICJkZXZpY2UiLCB0aGF0IGlzIHRoZSBjaG9pY2Ugb2YgdXNlcnMuDQo+IA0KPiBSaWdo
dCwgYnV0IGlmIHRoZSBkZXZpY2Ugc2ltcGx5IGhhcyBubyBETUEgb3BzIHN1cHBvcnRlZCwgaXQg
Y291bGQgYmUNCj4gYmV0dGVyIHRvIGZhaWwgdGhlIHByb2JlIHJhdGhlciB0aGFuIGxldCB0aGVt
IHRyeSB0aGUgdGVzdCBhdCBhbGwuDQo+IA0KPiAgIEFueWhvdywNCj4gPiB0aGUgYmVsb3cgY29k
ZSB3aWxsIHN0aWxsIGhhbmRsZSBpdCBwcm9wZXJseSBhbmQgdXNlcnMgd2lsbCBnZXQgYSByZXBv
cnQgaW4gd2hpY2gNCj4gPiBldmVyeXRoaW5nIGlzIHplcm8uDQo+ID4NCj4gPiArc3RhdGljIGlu
dCBtYXBfYmVuY2htYXJrX3RocmVhZCh2b2lkICpkYXRhKQ0KPiA+ICt7DQo+ID4gLi4uDQo+ID4g
KwkJZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShtYXAtPmRldiwgYnVmLCBQQUdFX1NJWkUsDQo+
IERNQV9CSURJUkVDVElPTkFMKTsNCj4gPiArCQlpZiAodW5saWtlbHkoZG1hX21hcHBpbmdfZXJy
b3IobWFwLT5kZXYsIGRtYV9hZGRyKSkpIHsNCj4gDQo+IERvaW5nIHRoaXMgaXMgcHJvcGVyLCBi
dXQgSSBhbSBub3Qgc3VyZSBpZiB0aGlzIHRlbGxzIHRoZSB1c2VyIHRoZSByZWFsDQo+IHByb2Js
ZW0uDQoNClRlbGxpbmcgdXNlcnMgdGhlIHJlYWwgcHJvYmxlbSBpc24ndCB0aGUgZGVzaWduIGlu
dGVudGlvbiBvZiB0aGlzIHRlc3QNCmJlbmNobWFyay4gSXQgaXMgbmV2ZXIgdGhlIHB1cnBvc2Ug
b2YgdGhpcyBiZW5jaG1hcmsuDQoNCj4gDQo+ID4gKwkJCXByX2VycigiZG1hX21hcF9zaW5nbGUg
ZmFpbGVkIG9uICVzXG4iLA0KPiBkZXZfbmFtZShtYXAtPmRldikpOw0KPiANCj4gTm90IHN1cmUg
d2h5IHVzZSBwcl9lcnIoKSBvdmVyIGRldl9lcnIoKS4NCg0KV2UgYXJlIHJlcG9ydGluZyBlcnJv
cnMgaW4gZG1hLWJlbmNobWFyayBkcml2ZXIgcmF0aGVyIHRoYW4gcmVwb3J0aW5nIGVycm9ycw0K
aW4gdGhlIGRyaXZlciBvZiB0aGUgc3BlY2lmaWMgZGV2aWNlLiBJIHRoaW5rIHdlIHNob3VsZCBo
YXZlICJkbWEtYmVuY2htYXJrIg0KYXMgdGhlIHByZWZpeCB3aGlsZSBwcmludGluZyB0aGUgbmFt
ZSBvZiB0aGUgZGV2aWNlIGJ5IGRldl9uYW1lKCkuDQoNCj4gDQo+ID4gKwkJCXJldCA9IC1FTk9N
RU07DQo+ID4gKwkJCWdvdG8gb3V0Ow0KPiA+ICsJCX0NCj4gDQo+IFRoYW5rcywNCj4gSm9obg0K
DQpUaGFua3MNCkJhcnJ5DQoNCg==
