Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAB24CCD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 06:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgHUEjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 00:39:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbgHUEjJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 00:39:09 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id A9E9FEB677D26FD3EF55;
        Fri, 21 Aug 2020 12:39:05 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 21 Aug 2020 12:39:05 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 21 Aug 2020 12:39:05 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 21 Aug 2020 12:39:05 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: RE: [PATCH] mm/gup_benchmark: update the documentation in Kconfig
Thread-Topic: [PATCH] mm/gup_benchmark: update the documentation in Kconfig
Thread-Index: AQHWd2sodq7dD0G0r06Gp6IiPRS+4KlBZ76AgACQqQA=
Date:   Fri, 21 Aug 2020 04:39:05 +0000
Message-ID: <00982d5512ba46fab841423ba9d39535@hisilicon.com>
References: <20200821032546.19992-1-song.bao.hua@hisilicon.com>
 <622e5ba7-41e9-0335-1630-cbcdaf9a162f@nvidia.com>
In-Reply-To: <622e5ba7-41e9-0335-1630-cbcdaf9a162f@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.192]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgta3NlbGZ0ZXN0
LW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4LWtzZWxmdGVzdC1vd25lckB2
Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBKb2huIEh1YmJhcmQNCj4gU2VudDogRnJpZGF5
LCBBdWd1c3QgMjEsIDIwMjAgMzo1MSBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25n
KSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+Ow0KPiBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgS2VpdGgNCj4gQnVzY2ggPGtlaXRoLmJ1c2NoQGludGVsLmNvbT47IEly
YSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT47IEtpcmlsbCBBIC4NCj4gU2h1dGVtb3YgPGtp
cmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1t
L2d1cF9iZW5jaG1hcms6IHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiBpbg0KPiBLY29uZmlnDQo+
IA0KPiBPbiA4LzIwLzIwIDg6MjUgUE0sIEJhcnJ5IFNvbmcgd3JvdGU6DQo+ID4gSW4gdGhlIGJl
Z2lubmluZywgbW0vZ3VwX2JlbmNobWFyay5jIHN1cHBvcnRlZCBnZXRfdXNlcl9wYWdlc19mYXN0
KCkNCj4gPiBvbmx5LCBidXQgcmlnaHQgbm93LCBpdCBzdXBwb3J0cyB0aGUgYmVuY2htYXJraW5n
IG9mIGEgY291cGxlIG9mDQo+ID4gZ2V0X3VzZXJfcGFnZXMoKSByZWxhdGVkIGNhbGxzIGxpa2U6
DQo+ID4gKiBnZXRfdXNlcl9wYWdlc19mYXN0KCkNCj4gPiAqIGdldF91c2VyX3BhZ2VzKCkNCj4g
PiAqIHBpbl91c2VyX3BhZ2VzX2Zhc3QoKQ0KPiA+ICogcGluX3VzZXJfcGFnZXMoKQ0KPiA+IFRo
ZSBkb2N1bWVudGF0aW9uIGlzIGNvbmZ1c2luZyBhbmQgbmVlZHMgdXBkYXRlLg0KPiANCj4gaG1t
bSwgaXQncyBub3QgdGhhdCBjb25mdXNpbmcsIGdpdmVuIHRoYXQgcGluX3VzZXJfcGFnZXMoKSBh
bmQNCj4gZ2V0X3VzZXJfcGFnZXMoKSB1c2UgdGhlIHNhbWUgdW5kZXJseWluZyBnZXRfdXNlcl9w
YWdlcygpDQo+IGltcGxlbWVudGF0aW9uLg0KDQpnZXRfdXNlcl9wYWdlc19mYXN0KCkgaXMgbm90
IGdldF91c2VyX3BhZ2VzKCkuIEl0IGlzIGEgc3BlY2lmaWMgZnVuY3Rpb24gOi0pDQoNCkluIHRo
ZSBiZWdpbm5pbmcsIGd1cF9iZW5jaG1hcmsgd2FzIG9ubHkgZm9yIGdldF91c2VyX3BhZ2VzX2Zh
c3QoKToNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9jb21taXQvbW0vZ3VwX2JlbmNobWFyay5jP2lkPTY0YzM0OWY0YWU3
OA0KDQoNCj4gDQo+ID4NCj4gPiBDYzogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29t
Pg0KPiA+IENjOiBLZWl0aCBCdXNjaCA8a2VpdGguYnVzY2hAaW50ZWwuY29tPg0KPiA+IENjOiBJ
cmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+ID4gQ2M6IEtpcmlsbCBBLiBTaHV0ZW1v
diA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
YXJyeSBTb25nIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT4NCj4gPiAtLS0NCj4gPiAgIG1t
L0tjb25maWcgfCA0ICsrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vS2NvbmZpZyBiL21tL0tj
b25maWcNCj4gPiBpbmRleCA2Yzk3NDg4OGY4NmYuLmY3YzkzNzRkYTdiMyAxMDA2NDQNCj4gPiAt
LS0gYS9tbS9LY29uZmlnDQo+ID4gKysrIGIvbW0vS2NvbmZpZw0KPiA+IEBAIC04MzEsMTAgKzgz
MSwxMCBAQCBjb25maWcgUEVSQ1BVX1NUQVRTDQo+ID4gICAJICBiZSB1c2VkIHRvIGhlbHAgdW5k
ZXJzdGFuZCBwZXJjcHUgbWVtb3J5IHVzYWdlLg0KPiA+DQo+ID4gICBjb25maWcgR1VQX0JFTkNI
TUFSSw0KPiA+IC0JYm9vbCAiRW5hYmxlIGluZnJhc3RydWN0dXJlIGZvciBnZXRfdXNlcl9wYWdl
c19mYXN0KCkgYmVuY2htYXJraW5nIg0KPiA+ICsJYm9vbCAiRW5hYmxlIGluZnJhc3RydWN0dXJl
IGZvciBnZXRfdXNlcl9wYWdlcygpIGFuZCByZWxhdGVkIGNhbGxzDQo+IGJlbmNobWFya2luZyIN
Cj4gDQo+IElmIHdlIHJlYWxseSB3YW50IHRvIGdvIHRvIHRoZSB0cm91YmxlIG9mIHR3ZWFraW5n
IHRoaXMsIHRoZW4gSSdkIGdvIHdpdGgNCj4gc29tZXRoaW5nIG1vcmUgbGlrZToNCj4gDQo+ICJF
bmFibGUgaW5mcmFzdHJ1Y3R1cmUgZm9yIGdldF91c2VyX3BhZ2VzKCkgYW5kIHBpbl91c2VyX3Bh
Z2VzIGJlbmNobWFya2luZyINCj4gDQo+IC4uLmJ1dCBJIGRvbid0IHRoaW5rIGl0IHJlYWxseSB3
YXJyYW50cyBhIHBhdGNoIGp1c3QgeWV0LiAqSG93ZXZlciosIG15DQo+IGp1ZGdtZW50IGlzIHNr
ZXdlZCByaWdodCBub3csIGJlY2F1c2UgSSdtIHBsYW5uaW5nIGEgc21hbGwgcGF0Y2hzZXQgdG8g
c3BsaXQNCj4gdXAgZ3VwX2JlbmNobWFyayBhIGxpdHRsZSBiaXQsIGFuZCB0byBhZGQgc29tZSBt
b3JlIHRlc3RpbmcgYW5kIHRha2UNCj4gYWR2YW50YWdlDQo+IG9mIHBhcnRzIG9mIGl0IHRvIGRv
IGEgZHVtcF9wYWdlKCkgdGVzdC4gQXQgd2hpY2ggcG9pbnQgInJlbGF0ZWQgY2FsbHMiIHdvdWxk
DQo+IG1ha2UgbW9yZSBzZW5zZSwgYnV0IHRoZW4gaXQgd291bGQgYmUgZGlmZmVyZW50IGVub3Vn
aCB0aGF0IHRoaXMgcGF0Y2ggd291bGQNCj4gc3RpbGwgbmVlZCBjaGFuZ2luZy4NCg0KT2suIEZh
aXIgZW5vdWdoLiBJIHdhcyBjb3B5aW5nIHRoZSAicmVsYXRlZCBjYWxscyIgZnJvbToNCkRvY3Vt
ZW50YXRpb24vY29yZS1hcGkvcGluX3VzZXJfcGFnZXMucnN0DQoNCj4gDQo+IFNvIEknbSBpbmNs
aW5lZCB0byBqdXN0IHJlY29tbWVuZCBsZWF2aW5nIHRoaXMgYWxvbmUgZm9yIGEgYml0LCBidXQg
aWYgb3RoZXJzDQo+IHdhbnQgdG8gcHV0IGl0IGluLCBJJ20gT0sgd2l0aCB0aGF0IHRvby4NCj4g
DQo+ID4gICAJaGVscA0KPiA+ICAgCSAgUHJvdmlkZXMgL3N5cy9rZXJuZWwvZGVidWcvZ3VwX2Jl
bmNobWFyayB0aGF0IGhlbHBzIHdpdGggdGVzdGluZw0KPiA+IC0JICBwZXJmb3JtYW5jZSBvZiBn
ZXRfdXNlcl9wYWdlc19mYXN0KCkuDQo+ID4gKwkgIHBlcmZvcm1hbmNlIG9mIGdldF91c2VyX3Bh
Z2VzKCkgYW5kIHJlbGF0ZWQgY2FsbHMuDQo+ID4NCj4gPiAgIAkgIFNlZSB0b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy92bS9ndXBfYmVuY2htYXJrLmMNCj4gPg0KDQpUaGFua3MNCkJhcnJ5DQoNCg0K
