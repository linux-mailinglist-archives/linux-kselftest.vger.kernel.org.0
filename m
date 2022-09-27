Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1D5EB6F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 03:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiI0BgY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Sep 2022 21:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiI0BgW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Sep 2022 21:36:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97448DF6;
        Mon, 26 Sep 2022 18:36:20 -0700 (PDT)
Received: from canpemm100008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc2Fc0v3kzpTpl;
        Tue, 27 Sep 2022 09:33:24 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100008.china.huawei.com (7.192.104.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:36:18 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Tue, 27 Sep 2022 09:36:18 +0800
From:   zhaogongyi <zhaogongyi@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: Re: [PATCH -next v3 1/3] selftests/memory-hotplug: Add checking after
 online or offline
Thread-Topic: [PATCH -next v3 1/3] selftests/memory-hotplug: Add checking
 after online or offline
Thread-Index: AdjSEXoq4KNGQqzodUStOJZvmVcVRQ==
Date:   Tue, 27 Sep 2022 01:36:18 +0000
Message-ID: <5484ea857c0644c9bdeb03bd3aa1c041@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DQo+IA0KPiBPbiAyNi4wOS4yMiAxNTowMywgWmhhbyBHb25neWkgd3JvdGU6DQo+ID4gQWRkIGNo
ZWNraW5nIGZvciBvbmxpbmVfbWVtb3J5X2V4cGVjdF9zdWNjZXNzKCkvDQo+ID4gb2ZmbGluZV9t
ZW1vcnlfZXhwZWN0X3N1Y2Nlc3MoKS9vZmZsaW5lX21lbW9yeV9leHBlY3RfZmFpbCgpLCBvcg0K
PiB0aGUNCj4gPiB0ZXN0IHdvdWxkIGV4aXQgMCBhbHRob3VnaCB0aGUgZnVuY3Rpb25zIHJldHVy
biAxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbyBHb25neWkgPHpoYW9nb25neWlAaHVh
d2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9zZWxmdGVzdHMvbWVtb3J5LWhvdHBsdWcvbWVt
LW9uLW9mZi10ZXN0LnNoICAgfCAxNQ0KPiArKysrKysrKysrKystLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYt
dGVzdC5zaA0KPiA+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5LWhvdHBsdWcvbWVt
LW9uLW9mZi10ZXN0LnNoDQo+ID4gaW5kZXggNDZhOTdmMzE4ZjU4Li4zZWRkYTFmMTNmN2IgMTAw
NzU1DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5LWhvdHBsdWcvbWVt
LW9uLW9mZi10ZXN0LnNoDQo+ID4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5
LWhvdHBsdWcvbWVtLW9uLW9mZi10ZXN0LnNoDQo+ID4gQEAgLTI2Niw3ICsyNjYsMTAgQEAgZG9u
ZQ0KPiA+ICAgIw0KPiA+ICAgZWNobyAkZXJyb3IgPg0KPiAkTk9USUZJRVJfRVJSX0lOSkVDVF9E
SVIvYWN0aW9ucy9NRU1fR09JTkdfT05MSU5FL2Vycm9yDQo+ID4gICBmb3IgbWVtb3J5IGluIGBo
b3RwbHVnZ2FibGVfb2ZmbGluZV9tZW1vcnlgOyBkbw0KPiA+IC0Jb25saW5lX21lbW9yeV9leHBl
Y3RfZmFpbCAkbWVtb3J5DQo+ID4gKwlvbmxpbmVfbWVtb3J5X2V4cGVjdF9mYWlsICRtZW1vcnkg
fHwgew0KPiA+ICsJCWVjaG8gIm9ubGluZSBtZW1vcnkgJG1lbW9yeTogdW5leHBlY3RlZCBzdWNj
ZXNzIg0KPiANCj4gVGhlIGZ1bmN0aW9ucyB0aGVtc2VsZiBhbHJlYWR5IHByaW50IGFuIGVycm9y
LCBpc24ndCBpdCBzdWZmaWNpZW50IHRvIHNldA0KPiByZXR2YWw9MT8NCg0KSW5kZWVkLCB0aGlz
IGZ1bmN0aW9uIGlzIG9ubHkgY2FsbGVkIG9uY2UuIEl0IGlzIG5vIG5lZWQgdG8gYWRkIHRoZSBs
b2cgaW5mby4NCg0KDQo+IA0KPiA+ICsJCXJldHZhbD0xDQo+ID4gKwl9DQo+ID4gICBkb25lDQo+
ID4NCj4gPiAgICMNCj4gPiBAQCAtMjc0LDcgKzI3NywxMCBAQCBkb25lDQo+ID4gICAjDQo+ID4g
ICBlY2hvIDAgPg0KPiAkTk9USUZJRVJfRVJSX0lOSkVDVF9ESVIvYWN0aW9ucy9NRU1fR09JTkdf
T05MSU5FL2Vycm9yDQo+ID4gICBmb3IgbWVtb3J5IGluIGBob3RwbHVnZ2FibGVfb2ZmbGluZV9t
ZW1vcnlgOyBkbw0KPiA+IC0Jb25saW5lX21lbW9yeV9leHBlY3Rfc3VjY2VzcyAkbWVtb3J5DQo+
ID4gKwlvbmxpbmVfbWVtb3J5X2V4cGVjdF9zdWNjZXNzICRtZW1vcnkgfHwgew0KPiA+ICsJCWVj
aG8gIm9ubGluZSBtZW1vcnkgJG1lbW9yeTogdW5leHBlY3RlZCBmYWlsIg0KPiA+ICsJCXJldHZh
bD0xDQo+ID4gKwl9DQo+ID4gICBkb25lDQo+ID4NCj4gPiAgICMNCj4gPiBAQCAtMjgzLDcgKzI4
OSwxMCBAQCBkb25lDQo+ID4gICBlY2hvICRlcnJvciA+DQo+ICROT1RJRklFUl9FUlJfSU5KRUNU
X0RJUi9hY3Rpb25zL01FTV9HT0lOR19PRkZMSU5FL2Vycm9yDQo+ID4gICBmb3IgbWVtb3J5IGlu
IGBob3RwbHVnZ2FibGVfb25saW5lX21lbW9yeWA7IGRvDQo+ID4gICAJaWYgWyAkKChSQU5ET00g
JSAxMDApKSAtbHQgJHJhdGlvIF07IHRoZW4NCj4gPiAtCQlvZmZsaW5lX21lbW9yeV9leHBlY3Rf
ZmFpbCAkbWVtb3J5DQo+ID4gKwkJb2ZmbGluZV9tZW1vcnlfZXhwZWN0X2ZhaWwgJG1lbW9yeSB8
fCB7DQo+ID4gKwkJCWVjaG8gIm9mZmxpbmUgbWVtb3J5ICRtZW1vcnk6IHVuZXhwZWN0ZWQgc3Vj
Y2VzcyINCj4gPiArCQkJcmV0dmFsPTENCj4gPiArCQl9DQo+IA0KPiBUaGVzZSBmdW5jdGlvbnMg
cmV0dXJuIDAgaWYgdGhlIHJlc3VsdCBpcyBhcyBleHBlY3RlZCBhbmQgMSBpZiB0aGUgcmVzdWx0
IGlzDQo+IHVuZXhwZWN0ZWQuDQo+IA0KPiAuLi4gYnV0IHdvdWxkbid0IHdlIGV2YWx1YXRlIHRo
ZSByaWdodCBoYW5kIHNpZGUgb25seSBpZiB0aGUgcmVzdWx0IGlzICIwIiAtLQ0KPiBleHBlY3Rl
ZD8gSSBtaWdodCBiZSB3cm9uZy4NCj4gDQoNClllcywgaWYgb2ZmbGluZV9tZW1vcnlfZXhwZWN0
X2ZhaWwncyByZXR1cm4gdmFsdWUgaXMgbm90IHplcm8sIHRoZW4gaXQgd2lsbCBzZXQgJ3JldHZh
bD0xJw0KDQo+IA0KPiBXb3VsZG4ndCBpdCBiZSBzaW1wbGVyIGRvIGl0IGFzIGluICJPbmxpbmUg
YWxsIGhvdC1wbHVnZ2FibGUgbWVtb3J5IGFnYWluIg0KPiANCj4gaWYgISBvbmxpbmVfbWVtb3J5
X2V4cGVjdF9zdWNjZXNzICRtZW1vcnk7IHRoZW4NCj4gCXJldHZhbD0xDQo+IGZpDQo+IA0KPiAo
c2ltaWxhcmx5IGFkanVzdGluZyB0aGUgZnVuY3Rpb24gbmFtZSkNCg0KSSB3aWxsIHNlbmQgYSBu
ZXcgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggdG8gZml4IGl0Lg0KDQpLaW5kIHJlZ2FyZHMsDQpHb25n
eWkNCg==
