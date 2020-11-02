Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42A2A2724
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 10:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKBJhh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 04:37:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:3654 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgKBJhh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 04:37:37 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CPnrY6cpCzXhrW;
        Mon,  2 Nov 2020 17:37:33 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 2 Nov 2020 17:37:33 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 2 Nov 2020 17:37:33 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Garry <john.garry@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "hch@lst.de" <hch@lst.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shuah Khan" <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Topic: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWsO+tiT3rvc8AvUKektYgWKvLn6m0CmcAgACIo/A=
Date:   Mon, 2 Nov 2020 09:37:33 +0000
Message-ID: <dc5be517e0ac4eaca50a5f8e3dc28170@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <184797b8-512e-e3da-fae7-25c7d662648b@huawei.com>
In-Reply-To: <184797b8-512e-e3da-fae7-25c7d662648b@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9obiBHYXJyeQ0KPiBT
ZW50OiBNb25kYXksIE5vdmVtYmVyIDIsIDIwMjAgMTA6MTkgUE0NCj4gVG86IFNvbmcgQmFvIEh1
YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPjsNCj4gaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGhjaEBsc3QuZGU7IHJvYmluLm11cnBoeUBhcm0uY29t
Ow0KPiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20NCj4gQ2M6IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7IFNodWFoIEtoYW4gPHNodWFoQGtlcm5lbC5vcmc+OyBKb2VyZw0KPiBSb2Vk
ZWwgPGpvcm9AOGJ5dGVzLm9yZz47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgeHV3
ZWkgKE8pDQo+IDx4dXdlaTVAaHVhd2VpLmNvbT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBkbWEtbWFwcGluZzogYWRkIGJlbmNo
bWFyayBzdXBwb3J0IGZvcg0KPiBzdHJlYW1pbmcgRE1BIEFQSXMNCj4gDQo+IE9uIDAyLzExLzIw
MjAgMDg6MDYsIEJhcnJ5IFNvbmcgd3JvdGU6DQo+ID4gTm93YWRheXMsIHRoZXJlIGFyZSBpbmNy
ZWFzaW5nIHJlcXVpcmVtZW50cyB0byBiZW5jaG1hcmsgdGhlIHBlcmZvcm1hbmNlDQo+ID4gb2Yg
ZG1hX21hcCBhbmQgZG1hX3VubWFwIHBhcnRpY3VhbGx5IHdoaWxlIHRoZSBkZXZpY2UgaXMgYXR0
YWNoZWQgdG8gYW4NCj4gPiBJT01NVS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZW5hYmxlcyB0aGUg
c3VwcG9ydC4gVXNlcnMgY2FuIHJ1biBzcGVjaWZpZWQgbnVtYmVyIG9mIHRocmVhZHMNCj4gPiB0
byBkbyBkbWFfbWFwX3BhZ2UgYW5kIGRtYV91bm1hcF9wYWdlIG9uIGEgc3BlY2lmaWMgTlVNQSBu
b2RlIHdpdGgNCj4gdGhlDQo+ID4gc3BlY2lmaWVkIGR1cmF0aW9uLiBUaGVuIGRtYV9tYXBfYmVu
Y2htYXJrIHdpbGwgY2FsY3VsYXRlIHRoZSBhdmVyYWdlDQo+ID4gbGF0ZW5jeSBmb3IgbWFwIGFu
ZCB1bm1hcC4NCj4gPg0KPiA+IEEgZGlmZmljdWxpdHkgZm9yIHRoaXMgYmVuY2htYXJrIGlzIHRo
YXQgZG1hX21hcC91bm1hcCBBUElzIG11c3QgcnVuIG9uDQo+ID4gYSBwYXJ0aWN1bGFyIGRldmlj
ZS4gRWFjaCBkZXZpY2UgbWlnaHQgaGF2ZSBkaWZmZXJlbnQgYmFja2VuZCBvZiBJT01NVSBvcg0K
PiA+IG5vbi1JT01NVS4NCj4gPg0KPiA+IFNvIHdlIHVzZSB0aGUgZHJpdmVyX292ZXJyaWRlIHRv
IGJpbmQgZG1hX21hcF9iZW5jaG1hcmsgdG8gYSBwYXJ0aWN1YWwNCj4gPiBkZXZpY2UgYnk6DQo+
ID4gRm9yIHBsYXRmb3JtIGRldmljZXM6DQo+ID4gZWNobyBkbWFfbWFwX2JlbmNobWFyayA+IC9z
eXMvYnVzL3BsYXRmb3JtL2RldmljZXMveHh4L2RyaXZlcl9vdmVycmlkZQ0KPiA+IGVjaG8geHh4
ID4gL3N5cy9idXMvcGxhdGZvcm0vZHJpdmVycy94eHgvdW5iaW5kDQo+ID4gZWNobyB4eHggPiAv
c3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2RtYV9tYXBfYmVuY2htYXJrL2JpbmQNCj4gPg0KPiA+
IEZvciBQQ0kgZGV2aWNlczoNCj4gPiBlY2hvIGRtYV9tYXBfYmVuY2htYXJrID4NCj4gL3N5cy9i
dXMvcGNpL2RldmljZXMvMDAwMDowMDowMS4wL2RyaXZlcl9vdmVycmlkZQ0KPiA+IGVjaG8gMDAw
MDowMDowMS4wID4gL3N5cy9idXMvcGNpL2RyaXZlcnMveHh4L3VuYmluZA0KPiA+IGVjaG8gMDAw
MDowMDowMS4wID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvZG1hX21hcF9iZW5jaG1hcmsvYmluZA0K
PiA+DQo+ID4gQ2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPg0KPiA+IENjOiBXaWxs
IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPg0KPiA+IENjOiBTaHVhaCBLaGFuIDxzaHVhaEBrZXJu
ZWwub3JnPg0KPiA+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gPiBDYzog
TWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPg0KPiA+IENjOiBSb2Jp
biBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhcnJ5
IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiA+IC0tLQ0KPiA+IC12MzoNCj4g
PiAgICAqIGZpeCBidWlsZCBpc3N1ZXMgcmVwb3J0ZWQgYnkgMGRheSBrZXJuZWwgdGVzdCByb2Jv
dA0KPiA+IC12MjoNCj4gPiAgICAqIGFkZCBQQ0kgc3VwcG9ydDsgdjEgc3VwcG9ydGVkIHBsYXRm
b3JtIGRldmljZXMgb25seQ0KPiA+ICAgICogcmVwbGFjZSBzc2xlZXAgYnkgbXNsZWVwX2ludGVy
cnVwdGlibGUoKSB0byBwZXJtaXQgdXNlcnMgdG8gZXhpdA0KPiA+ICAgICAgYmVuY2htYXJrIGJl
Zm9yZSBpdCBpcyBjb21wbGV0ZWQNCj4gPiAgICAqIG1hbnkgY2hhbmdlcyBhY2NvcmRpbmcgdG8g
Um9iaW4ncyBzdWdnZXN0aW9ucywgdGhhbmtzISBSb2Jpbg0KPiA+ICAgICAgLSBhZGQgc3RhbmRh
cmQgZGV2aWF0aW9uIG91dHB1dCB0byByZWZsZWN0IHRoZSB3b3JzdCBjYXNlDQo+ID4gICAgICAt
IGNoZWNrIHVzZXJzJyBwYXJhbWV0ZXJzIHN0cmljdGx5IGxpa2UgdGhlIG51bWJlciBvZiB0aHJl
YWRzDQo+ID4gICAgICAtIG1ha2UgY2FjaGUgZGlydHkgYmVmb3JlIGRtYV9tYXANCj4gPiAgICAg
IC0gZml4IHVucGFpcmVkIGRtYV9tYXBfcGFnZSBhbmQgZG1hX3VubWFwX3NpbmdsZTsNCj4gPiAg
ICAgIC0gcmVtb3ZlIHJlZHVuZGFudCAibG9uZyBsb25nIiBiZWZvcmUga3RpbWVfdG9fbnMoKTsN
Cj4gPiAgICAgIC0gdXNlIGRldm1fYWRkX2FjdGlvbigpDQo+ID4NCj4gPiAgIGtlcm5lbC9kbWEv
S2NvbmZpZyAgICAgICAgIHwgICA4ICsNCj4gPiAgIGtlcm5lbC9kbWEvTWFrZWZpbGUgICAgICAg
IHwgICAxICsNCj4gPiAgIGtlcm5lbC9kbWEvbWFwX2JlbmNobWFyay5jIHwgMjk2DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwg
MzA1IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBrZXJuZWwvZG1hL21h
cF9iZW5jaG1hcmsuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvS2NvbmZpZyBi
L2tlcm5lbC9kbWEvS2NvbmZpZw0KPiA+IGluZGV4IGM5OWRlNGEyMTQ1OC4uOTQ5YzUzZGE1OTkx
IDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9kbWEvS2NvbmZpZw0KPiA+ICsrKyBiL2tlcm5lbC9k
bWEvS2NvbmZpZw0KPiA+IEBAIC0yMjUsMyArMjI1LDExIEBAIGNvbmZpZyBETUFfQVBJX0RFQlVH
X1NHDQo+ID4gICAJICBpcyB0ZWNobmljYWxseSBvdXQtb2Ytc3BlYy4NCj4gPg0KPiA+ICAgCSAg
SWYgdW5zdXJlLCBzYXkgTi4NCj4gPiArDQo+ID4gK2NvbmZpZyBETUFfTUFQX0JFTkNITUFSSw0K
PiA+ICsJYm9vbCAiRW5hYmxlIGJlbmNobWFya2luZyBvZiBzdHJlYW1pbmcgRE1BIG1hcHBpbmci
DQo+ID4gKwloZWxwDQo+ID4gKwkgIFByb3ZpZGVzIC9zeXMva2VybmVsL2RlYnVnL2RtYV9tYXBf
YmVuY2htYXJrIHRoYXQgaGVscHMgd2l0aA0KPiB0ZXN0aW5nDQo+ID4gKwkgIHBlcmZvcm1hbmNl
IG9mIGRtYV8odW4pbWFwX3BhZ2UuDQo+IA0KPiBTaW5jZSB0aGlzIGlzIGEgZHJpdmVyLCBhbnkg
cmVhc29uIGZvciB3aGljaCBpdCBjYW5ub3QgYmUgbG9hZGFibGU/IElmDQo+IHNvLCBpdCBzZWVt
cyBhbnkgZnVuY3Rpb25hbGl0eSB3b3VsZCBkZXBlbmQgb24gREVCVUcgRlMsIEkgZmlndXJlIHRo
YXQncw0KPiBqdXN0IGhvdyB3ZSB3b3JrIGZvciBkZWJ1Z2ZzLg0KDQpXZSBkZXBlbmQgb24ga3Ro
cmVhZF9iaW5kX21hc2sgd2hpY2ggaXNuJ3QgYW4gZXhwb3J0X3N5bWJvbC4NCk1heWJlIHdvcnRo
IHRvIHNlbmQgYSBwYXRjaCB0byBleHBvcnQgaXQ/DQoNCj4gDQo+IFRoYW5rcywNCj4gSm9obg0K
PiANCj4gPiArDQo+ID4gKwkgIFNlZSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWEvZG1hX21h
cF9iZW5jaG1hcmsuYw0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL01ha2VmaWxlIGIva2Vy
bmVsL2RtYS9NYWtlZmlsZQ0KPiA+IGluZGV4IGRjNzU1YWI2OGFhYi4uN2FhNmIyNmIxMzQ4IDEw
MDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9kbWEvTWFrZWZpbGUNCj4gPiArKysgYi9rZXJuZWwvZG1h
L01ha2VmaWxlDQoNClRoYW5rcw0KQmFycnkNCg0K
