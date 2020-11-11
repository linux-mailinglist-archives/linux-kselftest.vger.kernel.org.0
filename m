Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B622AE5D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 02:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgKKB3L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 20:29:11 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2059 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbgKKB3L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 20:29:11 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CW6ZW6CSbzVmnF;
        Wed, 11 Nov 2020 09:28:51 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 11 Nov 2020 09:29:08 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Wed, 11 Nov 2020 09:29:08 +0800
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
Thread-Index: AQHWsO+tiT3rvc8AvUKektYgWKvLn6nBDT6Q//+EgQCAAZyYMA==
Date:   Wed, 11 Nov 2020 01:29:08 +0000
Message-ID: <88e91063b7f041bda7d147438f1c4621@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
 <0658ee16-d539-61c5-1d39-77d50f559803@huawei.com>
In-Reply-To: <0658ee16-d539-61c5-1d39-77d50f559803@huawei.com>
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
ZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxMCwgMjAyMCA5OjM5IFBNDQo+IFRvOiBTb25nIEJhbyBI
dWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47DQo+IGlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBoY2hAbHN0LmRlOyByb2Jpbi5tdXJwaHlAYXJtLmNv
bTsNCj4gbS5zenlwcm93c2tpQHNhbXN1bmcuY29tDQo+IENjOiBsaW51eC1rc2VsZnRlc3RAdmdl
ci5rZXJuZWwub3JnOyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgSm9lcmcNCj4gUm9l
ZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IHh1
d2VpIChPKQ0KPiA8eHV3ZWk1QGh1YXdlaS5jb20+OyBTaHVhaCBLaGFuIDxzaHVhaEBrZXJuZWwu
b3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZG1hLW1hcHBpbmc6IGFkZCBiZW5j
aG1hcmsgc3VwcG9ydCBmb3INCj4gc3RyZWFtaW5nIERNQSBBUElzDQo+IA0KPiBPbiAxMC8xMS8y
MDIwIDA4OjEwLCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIHdyb3RlOg0KPiA+IEhlbGxvIFJv
YmluLCBDaHJpc3RvcGgsDQo+ID4gQW55IGZ1cnRoZXIgY29tbWVudD8gSm9obiBzdWdnZXN0ZWQg
dGhhdCAiZGVwZW5kcyBvbiBERUJVR19GUyIgc2hvdWxkDQo+IGJlIGFkZGVkIGluIEtjb25maWcu
DQo+ID4gSSBhbSBjb2xsZWN0aW5nIG1vcmUgY29tbWVudHMgdG8gc2VuZCB2NCB0b2dldGhlciB3
aXRoIGZpeGluZyB0aGlzIG1pbm9yDQo+IGlzc3VlIDotKQ0KPiA+DQo+ID4gVGhhbmtzDQo+ID4g
QmFycnkNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBT
b25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+ID4+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMiwg
MjAyMCA5OjA3IFBNDQo+ID4+IFRvOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsg
aGNoQGxzdC5kZTsNCj4gcm9iaW4ubXVycGh5QGFybS5jb207DQo+ID4+IG0uc3p5cHJvd3NraUBz
YW1zdW5nLmNvbQ0KPiA+PiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsaW51
eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOw0KPiB4dXdlaQ0KPiA+PiAoTykgPHh1d2VpNUBo
dWF3ZWkuY29tPjsgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA+PiA8c29uZy5iYW8uaHVh
QGhpc2lsaWNvbi5jb20+OyBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz47IFdpbGwNCj4g
RGVhY29uDQo+ID4+IDx3aWxsQGtlcm5lbC5vcmc+OyBTaHVhaCBLaGFuIDxzaHVhaEBrZXJuZWwu
b3JnPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMS8yXSBkbWEtbWFwcGluZzogYWRkIGJlbmNo
bWFyayBzdXBwb3J0IGZvcg0KPiBzdHJlYW1pbmcNCj4gPj4gRE1BIEFQSXMNCj4gPj4NCj4gPj4g
Tm93YWRheXMsIHRoZXJlIGFyZSBpbmNyZWFzaW5nIHJlcXVpcmVtZW50cyB0byBiZW5jaG1hcmsg
dGhlDQo+IHBlcmZvcm1hbmNlDQo+ID4+IG9mIGRtYV9tYXAgYW5kIGRtYV91bm1hcCBwYXJ0aWN1
YWxseSB3aGlsZSB0aGUgZGV2aWNlIGlzIGF0dGFjaGVkIHRvIGFuDQo+ID4+IElPTU1VLg0KPiA+
Pg0KPiA+PiBUaGlzIHBhdGNoIGVuYWJsZXMgdGhlIHN1cHBvcnQuIFVzZXJzIGNhbiBydW4gc3Bl
Y2lmaWVkIG51bWJlciBvZiB0aHJlYWRzDQo+IHRvDQo+ID4+IGRvIGRtYV9tYXBfcGFnZSBhbmQg
ZG1hX3VubWFwX3BhZ2Ugb24gYSBzcGVjaWZpYyBOVU1BIG5vZGUgd2l0aA0KPiB0aGUNCj4gPj4g
c3BlY2lmaWVkIGR1cmF0aW9uLiBUaGVuIGRtYV9tYXBfYmVuY2htYXJrIHdpbGwgY2FsY3VsYXRl
IHRoZSBhdmVyYWdlDQo+ID4+IGxhdGVuY3kgZm9yIG1hcCBhbmQgdW5tYXAuDQo+ID4+DQo+ID4+
IEEgZGlmZmljdWxpdHkgZm9yIHRoaXMgYmVuY2htYXJrIGlzIHRoYXQgZG1hX21hcC91bm1hcCBB
UElzIG11c3QgcnVuIG9uIGENCj4gPj4gcGFydGljdWxhciBkZXZpY2UuIEVhY2ggZGV2aWNlIG1p
Z2h0IGhhdmUgZGlmZmVyZW50IGJhY2tlbmQgb2YgSU9NTVUgb3INCj4gPj4gbm9uLUlPTU1VLg0K
PiA+Pg0KPiA+PiBTbyB3ZSB1c2UgdGhlIGRyaXZlcl9vdmVycmlkZSB0byBiaW5kIGRtYV9tYXBf
YmVuY2htYXJrIHRvIGEgcGFydGljdWFsDQo+ID4+IGRldmljZSBieToNCj4gPj4gRm9yIHBsYXRm
b3JtIGRldmljZXM6DQo+ID4+IGVjaG8gZG1hX21hcF9iZW5jaG1hcmsgPg0KPiAvc3lzL2J1cy9w
bGF0Zm9ybS9kZXZpY2VzL3h4eC9kcml2ZXJfb3ZlcnJpZGUNCj4gPj4gZWNobyB4eHggPiAvc3lz
L2J1cy9wbGF0Zm9ybS9kcml2ZXJzL3h4eC91bmJpbmQNCj4gPj4gZWNobyB4eHggPiAvc3lzL2J1
cy9wbGF0Zm9ybS9kcml2ZXJzL2RtYV9tYXBfYmVuY2htYXJrL2JpbmQNCj4gPj4NCj4gDQo+IEhp
IEJhcnJ5LA0KPiANCj4gPj4gRm9yIFBDSSBkZXZpY2VzOg0KPiA+PiBlY2hvIGRtYV9tYXBfYmVu
Y2htYXJrID4NCj4gPj4gL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDowMS4wL2RyaXZlcl9v
dmVycmlkZQ0KPiA+PiBlY2hvIDAwMDA6MDA6MDEuMCA+IC9zeXMvYnVzL3BjaS9kcml2ZXJzL3h4
eC91bmJpbmQgZWNobyAwMDAwOjAwOjAxLjAgPg0KPiA+PiAvc3lzL2J1cy9wY2kvZHJpdmVycy9k
bWFfbWFwX2JlbmNobWFyay9iaW5kDQo+IA0KPiBEbyB3ZSBuZWVkIHRvIGNoZWNrIGlmIHRoZSBk
ZXZpY2UgdG8gd2hpY2ggd2UgYXR0YWNoIGFjdHVhbGx5IGhhcyBETUENCj4gbWFwcGluZyBjYXBh
YmlsaXR5Pw0KDQpIZWxsbyBKb2huLA0KDQpJJ2QgbGlrZSB0byB0aGluayBjaGVja2luZyB0aGlz
IGhlcmUgd291bGQgYmUgb3ZlcmRlc2lnbi4gV2UganVzdCBnaXZlIHVzZXJzIHRoZQ0KZnJlZWRv
bSB0byBiaW5kIGFueSBkZXZpY2UgdGhleSBjYXJlIGFib3V0IHRvIHRoZSBiZW5jaG1hcmsgZHJp
dmVyLiBVc3VhbGx5DQp0aGF0IG1lYW5zIGEgcmVhbCBoYXJkd2FyZSBlaXRoZXIgYmVoaW5kIGFu
IElPTU1VIG9yIHRocm91Z2ggYSBkaXJlY3QNCm1hcHBpbmcuDQoNCmlmIGZvciBhbnkgcmVhc29u
IHVzZXJzIHB1dCBhIHdyb25nICJkZXZpY2UiLCB0aGF0IGlzIHRoZSBjaG9pY2Ugb2YgdXNlcnMu
IEFueWhvdywNCnRoZSBiZWxvdyBjb2RlIHdpbGwgc3RpbGwgaGFuZGxlIGl0IHByb3Blcmx5IGFu
ZCB1c2VycyB3aWxsIGdldCBhIHJlcG9ydCBpbiB3aGljaA0KZXZlcnl0aGluZyBpcyB6ZXJvLg0K
DQorc3RhdGljIGludCBtYXBfYmVuY2htYXJrX3RocmVhZCh2b2lkICpkYXRhKQ0KK3sNCi4uLg0K
KwkJZG1hX2FkZHIgPSBkbWFfbWFwX3NpbmdsZShtYXAtPmRldiwgYnVmLCBQQUdFX1NJWkUsIERN
QV9CSURJUkVDVElPTkFMKTsNCisJCWlmICh1bmxpa2VseShkbWFfbWFwcGluZ19lcnJvcihtYXAt
PmRldiwgZG1hX2FkZHIpKSkgew0KKwkJCXByX2VycigiZG1hX21hcF9zaW5nbGUgZmFpbGVkIG9u
ICVzXG4iLCBkZXZfbmFtZShtYXAtPmRldikpOw0KKwkJCXJldCA9IC1FTk9NRU07DQorCQkJZ290
byBvdXQ7DQorCQl9DQouLi4NCit9DQoNCj4gDQo+ID4+DQo+ID4+IENjOiBKb2VyZyBSb2VkZWwg
PGpvcm9AOGJ5dGVzLm9yZz4NCj4gPj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+
DQo+ID4+IENjOiBTaHVhaCBLaGFuIDxzaHVhaEBrZXJuZWwub3JnPg0KPiA+PiBDYzogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+ID4+IENjOiBNYXJlayBTenlwcm93c2tpIDxtLnN6
eXByb3dza2lAc2Ftc3VuZy5jb20+DQo+ID4+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCYXJyeSBTb25nIDxzb25nLmJhby5odWFA
aGlzaWxpY29uLmNvbT4NCj4gPj4gLS0tDQo+IA0KPiBUaGFua3MsDQo+IEpvaG4NCg0KVGhhbmtz
DQpCYXJyeQ0KDQo=
