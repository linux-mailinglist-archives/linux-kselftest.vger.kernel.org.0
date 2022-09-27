Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E405A5EC1EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiI0L4S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiI0L4S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 07:56:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB571125;
        Tue, 27 Sep 2022 04:56:16 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McHzZ28D4zWgxD;
        Tue, 27 Sep 2022 19:52:10 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 19:56:14 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Tue, 27 Sep 2022 19:56:14 +0800
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
Subject: Re: [PATCH -next v4 1/3] selftests/memory-hotplug: Add checking after
 online or offline
Thread-Topic: [PATCH -next v4 1/3] selftests/memory-hotplug: Add checking
 after online or offline
Thread-Index: AdjSZ70agPM4MSRHq0+s99zfeKpZsg==
Date:   Tue, 27 Sep 2022 11:56:14 +0000
Message-ID: <dd8998bcfe0e4b82a617dfd79d93368c@huawei.com>
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

SGkhDQoNCj4gDQo+IE9uIDI3LjA5LjIyIDA1OjI4LCBaaGFvIEdvbmd5aSB3cm90ZToNCj4gPiBB
ZGQgY2hlY2tpbmcgZm9yIG9ubGluZV9tZW1vcnlfZXhwZWN0X3N1Y2Nlc3MoKS8NCj4gPiBvZmZs
aW5lX21lbW9yeV9leHBlY3Rfc3VjY2VzcygpL29mZmxpbmVfbWVtb3J5X2V4cGVjdF9mYWlsKCks
IG9yIHRoZQ0KPiA+IHRlc3Qgd291bGQgZXhpdCAwIGFsdGhvdWdoIHRoZSBmdW5jdGlvbnMgcmV0
dXJuIDEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFvIEdvbmd5aSA8emhhb2dvbmd5aUBo
dWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9t
ZW0tb24tb2ZmLXRlc3Quc2ggICAgICB8IDEyDQo+ICsrKysrKysrKy0tLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0tb24tb2Zm
LXRlc3Quc2gNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21l
bS1vbi1vZmYtdGVzdC5zaA0KPiA+IGluZGV4IDQ2YTk3ZjMxOGY1OC4uMWQ4NzYxMWE3ZDUyIDEw
MDc1NQ0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21l
bS1vbi1vZmYtdGVzdC5zaA0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9y
eS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaA0KPiA+IEBAIC0yNjYsNyArMjY2LDkgQEAgZG9u
ZQ0KPiA+ICAgIw0KPiA+ICAgZWNobyAkZXJyb3IgPg0KPiAkTk9USUZJRVJfRVJSX0lOSkVDVF9E
SVIvYWN0aW9ucy9NRU1fR09JTkdfT05MSU5FL2Vycm9yDQo+ID4gICBmb3IgbWVtb3J5IGluIGBo
b3RwbHVnZ2FibGVfb2ZmbGluZV9tZW1vcnlgOyBkbw0KPiA+IC0Jb25saW5lX21lbW9yeV9leHBl
Y3RfZmFpbCAkbWVtb3J5DQo+ID4gKwlpZiAhIG9ubGluZV9tZW1vcnlfZXhwZWN0X2ZhaWwgJG1l
bW9yeTsgdGhlbg0KPiA+ICsJCXJldHZhbD0xDQo+ID4gKwlmaQ0KPiA+ICAgZG9uZQ0KPiA+DQo+
ID4gICAjDQo+ID4gQEAgLTI3NCw3ICsyNzYsOSBAQCBkb25lDQo+ID4gICAjDQo+ID4gICBlY2hv
IDAgPg0KPiAkTk9USUZJRVJfRVJSX0lOSkVDVF9ESVIvYWN0aW9ucy9NRU1fR09JTkdfT05MSU5F
L2Vycm9yDQo+ID4gICBmb3IgbWVtb3J5IGluIGBob3RwbHVnZ2FibGVfb2ZmbGluZV9tZW1vcnlg
OyBkbw0KPiA+IC0Jb25saW5lX21lbW9yeV9leHBlY3Rfc3VjY2VzcyAkbWVtb3J5DQo+ID4gKwlp
ZiAhIG9ubGluZV9tZW1vcnlfZXhwZWN0X3N1Y2Nlc3MgJG1lbW9yeTsgdGhlbg0KPiA+ICsJCXJl
dHZhbD0xDQo+ID4gKwlmaQ0KPiA+ICAgZG9uZQ0KPiA+DQo+ID4gICAjDQo+ID4gQEAgLTI4Myw3
ICsyODcsOSBAQCBkb25lDQo+ID4gICBlY2hvICRlcnJvciA+DQo+ICROT1RJRklFUl9FUlJfSU5K
RUNUX0RJUi9hY3Rpb25zL01FTV9HT0lOR19PRkZMSU5FL2Vycm9yDQo+ID4gICBmb3IgbWVtb3J5
IGluIGBob3RwbHVnZ2FibGVfb25saW5lX21lbW9yeWA7IGRvDQo+ID4gICAJaWYgWyAkKChSQU5E
T00gJSAxMDApKSAtbHQgJHJhdGlvIF07IHRoZW4NCj4gPiAtCQlvZmZsaW5lX21lbW9yeV9leHBl
Y3RfZmFpbCAkbWVtb3J5DQo+ID4gKwkJaWYgISBvZmZsaW5lX21lbW9yeV9leHBlY3RfZmFpbCAk
bWVtb3J5OyB0aGVuDQo+ID4gKwkJCXJldHZhbD0xDQo+ID4gKwkJZmkNCj4gPiAgIAlmaQ0KPiAN
Cj4gDQo+IExHVE0NCj4gDQo+IFJldmlld2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4NCj4gDQo+IA0KPiBJIGFtIHF1ZXN0aW9uaW5nIHRoZSBzdGFiaWxpdHkgb2Yg
dGhlIG9mZmxpbmluZyB0ZXN0LCB0aG91Z2guDQo+IE9mZmxpbmluZyBhIHJhbmRvbSBtZW1vcnkg
YmxvY2sgY2FuIGZhaWwgZWFzaWx5LCBiZWNhdXNlICItPnJlbW92YWJsZSIgaXMgbm90DQo+IGV4
cHJlc3NpdmU6DQo+IA0KPiAjIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVn
L21lbS1vbi1vZmYtdGVzdC5zaA0KPiBUZXN0IHNjb3BlOiAyJSBob3RwbHVnIG1lbW9yeQ0KPiAg
ICAgICAgICAgb25saW5lIGFsbCBob3QtcGx1Z2dhYmxlIG1lbW9yeSBpbiBvZmZsaW5lIHN0YXRl
Og0KPiAgICAgICAgICAgICAgICAgICBTS0lQUEVEIC0gbm8gaG90LXBsdWdnYWJsZSBtZW1vcnkg
aW4gb2ZmbGluZSBzdGF0ZQ0KPiAgICAgICAgICAgb2ZmbGluZSAyJSBob3QtcGx1Z2dhYmxlIG1l
bW9yeSBpbiBvbmxpbmUgc3RhdGUNCj4gICAgICAgICAgIHRyeWluZyB0byBvZmZsaW5lIDIgb3V0
IG9mIDk2IG1lbW9yeSBibG9jayhzKToNCj4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTANCj4gdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5LWhvdHBsdWcvbWVtLW9uLW9mZi10ZXN0LnNoOiBs
aW5lIDc4OiBlY2hvOg0KPiB3cml0ZSBlcnJvcjogSW52YWxpZCBhcmd1bWVudCBvZmZsaW5lX21l
bW9yeV9leHBlY3Rfc3VjY2VzcyAwOiB1bmV4cGVjdGVkDQo+IGZhaWwNCj4gb25saW5lLT5vZmZs
aW5lIG1lbW9yeTEwDQo+IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMQ0KPiANCj4gDQo+IEkgZ3Vl
c3MgdGhpcyB0ZXN0IHdpbGwgYWxtb3N0IGFsd2F5cyBmYWlsIG5vd2FkYXlzLg0KDQpPZmZsaW5l
IHNvbWUgbWVtb3J5IG5vZGUgbWF5YmUgZmFpbGVkIGFzIGV4cGVjdGVkLCBidXQgdGhlIGVycm9y
IG1lc3NhZ2UgaXMgYSBiaXQgYW5ub3lpbmcuDQoNCg0KPiANCj4gLS0NCj4gVGhhbmtzLA0KPiAN
Cj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=
