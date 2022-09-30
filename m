Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DED25F06E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiI3Iwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiI3Iwy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 04:52:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD62166F34;
        Fri, 30 Sep 2022 01:52:53 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mf3mK1dmXzlXSn;
        Fri, 30 Sep 2022 16:48:33 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 16:52:52 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Fri, 30 Sep 2022 16:52:52 +0800
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
Thread-Index: AdjUqWSTmxHH4sO5SHuE6BL6lEWgMA==
Date:   Fri, 30 Sep 2022 08:52:51 +0000
Message-ID: <276cce524b1146119f8a0e9ec00a2ba9@huawei.com>
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

SGkhDQoNCj4gDQo+IE9uIDMwLjA5LjIyIDA4OjM1LCBaaGFvIEdvbmd5aSB3cm90ZToNCj4gPiBT
b21lIG1vbW9yeSB3aWxsIGJlIGxlZnQgaW4gb2ZmbGluZSBzdGF0ZSB3aGVuIGNhbGxpbmcNCj4g
PiBvZmZsaW5lX21lbW9yeV9leHBlY3RfZmFpbCgpIGZhaWxlZC4gUmVzdG9yZSBpdCBiZWZvcmUg
ZXhpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW8gR29uZ3lpIDx6aGFvZ29uZ3lpQGh1
YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vbWVtb3J5LWhvdHBsdWcvbWVtLW9uLW9mZi10
ZXN0LnNoICAgICAgICAgfCAyMQ0KPiArKysrKysrKysrKysrKy0tLS0tDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0tb24tb2Zm
LXRlc3Quc2gNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0t
b24tb2ZmLXRlc3Quc2gNCj4gPiBpbmRleCAxZDg3NjExYTdkNTIuLjkxYTc0NTc2MTZiYiAxMDA3
NTUNCj4gPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0t
b24tb2ZmLXRlc3Quc2gNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnkt
aG90cGx1Zy9tZW0tb24tb2ZmLXRlc3Quc2gNCj4gPiBAQCAtMTM0LDYgKzEzNCwxNiBAQCBvZmZs
aW5lX21lbW9yeV9leHBlY3RfZmFpbCgpDQo+ID4gICAJcmV0dXJuIDANCj4gPiAgIH0NCj4gPg0K
PiA+ICtvbmxpbmVfYWxsX29mZmxpbmVfbWVtb3J5KCkNCj4gPiArew0KPiA+ICsJZm9yIG1lbW9y
eSBpbiBgaG90cGx1Z2dhYmxlX29mZmxpbmVfbWVtb3J5YDsgZG8NCj4gPiArCQlpZiAhIG9ubGlu
ZV9tZW1vcnlfZXhwZWN0X3N1Y2Nlc3MgJG1lbW9yeTsgdGhlbg0KPiA+ICsJCQllY2hvICIkRlVO
Q05BTUUgJG1lbW9yeTogdW5leHBlY3RlZCBmYWlsIiA+JjINCj4gDQo+IERvIHdlIG5lZWQgdGhh
dCBvdXRwdXQ/DQoNCkluIG15IG9waW5pb24sIGlmIG9ubGluZSBhIG1lbW9yeSBub2RlIGZhaWxl
ZCAsaXQgc2hvdWxkIGJlIGEga2VybmVsIGJ1ZyBjYXRjaGVkLCBzbywgSSB0aGluayB0aGUgb3V0
cHV0IGhlcmUgaXMgbmVlZGVkLg0KDQpUaGFua3MhDQoNCkdvbmd5aQ0K
