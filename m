Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872CC5F8211
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Oct 2022 03:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJHBlP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Oct 2022 21:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJHBlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Oct 2022 21:41:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE340005;
        Fri,  7 Oct 2022 18:40:57 -0700 (PDT)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MknpC0vKtzVj0L;
        Sat,  8 Oct 2022 09:36:35 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 09:40:55 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Sat, 8 Oct 2022 09:40:55 +0800
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
Subject: Re: [PATCH -next v5 2/4] selftests/memory-hotplug: Restore memory
 before exit
Thread-Topic: [PATCH -next v5 2/4] selftests/memory-hotplug: Restore memory
 before exit
Thread-Index: AdjatvepmxHH4sO5SHuE6BL6lEWgMA==
Date:   Sat, 8 Oct 2022 01:40:55 +0000
Message-ID: <f83730eec0b1445fa92d4cf0397d886b@huawei.com>
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

SGkhDQoNCj4gDQo+IE9uIDMwLjA5LjIyIDEwOjUyLCB6aGFvZ29uZ3lpIHdyb3RlOg0KPiA+IEhp
IQ0KPiA+DQo+ID4+DQo+ID4+IE9uIDMwLjA5LjIyIDA4OjM1LCBaaGFvIEdvbmd5aSB3cm90ZToN
Cj4gPj4+IFNvbWUgbW9tb3J5IHdpbGwgYmUgbGVmdCBpbiBvZmZsaW5lIHN0YXRlIHdoZW4gY2Fs
bGluZw0KPiA+Pj4gb2ZmbGluZV9tZW1vcnlfZXhwZWN0X2ZhaWwoKSBmYWlsZWQuIFJlc3RvcmUg
aXQgYmVmb3JlIGV4aXQuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWmhhbyBHb25neWkg
PHpoYW9nb25neWlAaHVhd2VpLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgLi4uL21lbW9yeS1o
b3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaCAgICAgICAgIHwgMjENCj4gPj4gKysrKysrKysrKysr
KystLS0tLQ0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaA0KPiA+PiBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaA0KPiA+Pj4gaW5k
ZXggMWQ4NzYxMWE3ZDUyLi45MWE3NDU3NjE2YmIgMTAwNzU1DQo+ID4+PiAtLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0tb24tb2ZmLXRlc3Quc2gNCj4gPj4+
ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21lbS1vbi1vZmYt
dGVzdC5zaA0KPiA+Pj4gQEAgLTEzNCw2ICsxMzQsMTYgQEAgb2ZmbGluZV9tZW1vcnlfZXhwZWN0
X2ZhaWwoKQ0KPiA+Pj4gICAgCXJldHVybiAwDQo+ID4+PiAgICB9DQo+ID4+Pg0KPiA+Pj4gK29u
bGluZV9hbGxfb2ZmbGluZV9tZW1vcnkoKQ0KPiA+Pj4gK3sNCj4gPj4+ICsJZm9yIG1lbW9yeSBp
biBgaG90cGx1Z2dhYmxlX29mZmxpbmVfbWVtb3J5YDsgZG8NCj4gPj4+ICsJCWlmICEgb25saW5l
X21lbW9yeV9leHBlY3Rfc3VjY2VzcyAkbWVtb3J5OyB0aGVuDQo+ID4+PiArCQkJZWNobyAiJEZV
TkNOQU1FICRtZW1vcnk6IHVuZXhwZWN0ZWQgZmFpbCIgPiYyDQo+ID4+DQo+ID4+IERvIHdlIG5l
ZWQgdGhhdCBvdXRwdXQ/DQo+ID4NCj4gPiBJbiBteSBvcGluaW9uLCBpZiBvbmxpbmUgYSBtZW1v
cnkgbm9kZSBmYWlsZWQgLGl0IHNob3VsZCBiZSBhIGtlcm5lbCBidWcNCj4gY2F0Y2hlZCwgc28s
IEkgdGhpbmsgdGhlIG91dHB1dCBoZXJlIGlzIG5lZWRlZC4NCj4gDQo+IEJ1dCBvbmxpbmVfbWVt
b3J5X2V4cGVjdF9zdWNjZXNzKCkgYWxyZWFkeSBwcmludHMgYSB3YXJuaW5nLCBubz8NCg0KWWVz
LCBvbmxpbmVfbWVtb3J5X2V4cGVjdF9zdWNjZXNzKCkgYWxyZWFkeSBwcmludHMgYSB3YXJuaW5n
LCByZW1vdmUgdGhlIHdhcm5pbmcgaW4gb25saW5lX2FsbF9vZmZsaW5lX21lbW9yeSgpIHNlZW1z
IG9rLA0KDQpNeSBwcmV2aW91cyBjb25zaWRlcmF0aW9uIHdhcyB0aGF0IG9uZSBtb3JlIGxvZyBp
bmZvcm1hdGlvbiB3b3VsZCBtYWtlIGl0IGVhc2llciB0byBsb2NhdGUgdGhlIHdyb25nIGxvY2F0
aW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpHb25neWkNCg==
