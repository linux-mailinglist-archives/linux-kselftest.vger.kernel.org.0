Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0245EF4F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 14:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiI2MI3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiI2MI2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 08:08:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E097147A26;
        Thu, 29 Sep 2022 05:08:26 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MdX8Q597Lz1P6w4;
        Thu, 29 Sep 2022 20:04:06 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 20:08:24 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Thu, 29 Sep 2022 20:08:24 +0800
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
Thread-Index: AdjT+ytsJOcEj+v4TUG4sPNhxFl26Q==
Date:   Thu, 29 Sep 2022 12:08:24 +0000
Message-ID: <96c8944284974e08a63d02dac1fa2601@huawei.com>
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

SGkhDQoNCj4gDQo+IE9uIDI5LjA5LjIyIDA5OjM5LCB6aGFvZ29uZ3lpIHdyb3RlOg0KPiA+IEhp
LA0KPiA+DQo+ID4gV2UgY2FuIG5vdCBnZXQgdGhlIEVCVVNZIGZyb20gIiBlY2hvIDAgPg0KPiAv
c3lzL2RldmljZXMvc3lzdGVtL21lbW9yeS9tZW1vcnl4eHgvb25saW5lIiwgbWF5YmUsIHJlZGly
ZWN0IHRoZSBlcnJvcg0KPiBvdXB1dCB0byAvZGV2L251bGwgaXMgc3VpdGFibGUgd2hlbiBjYWxs
aW5nIG9mZmxpbmVfbWVtb3J5X2V4cGVjdF9zdWNjZXNzKCk6DQo+ID4NCj4gPiAjIHNoIG1lbS1v
bi1vZmYtdGVzdC5zaCAtYQ0KPiA+IG1lbS1vbi1vZmYtdGVzdC5zaDogaWxsZWdhbCBvcHRpb24g
LS0gYSBUZXN0IHNjb3BlOiAyJSBob3RwbHVnIG1lbW9yeQ0KPiA+ICAgICAgICAgICBvbmxpbmUg
YWxsIGhvdC1wbHVnZ2FibGUgbWVtb3J5IGluIG9mZmxpbmUgc3RhdGU6DQo+ID4gICAgICAgICAg
ICAgICAgICAgU0tJUFBFRCAtIG5vIGhvdC1wbHVnZ2FibGUgbWVtb3J5IGluIG9mZmxpbmUgc3Rh
dGUNCj4gPiAgICAgICAgICAgb2ZmbGluZSAyJSBob3QtcGx1Z2dhYmxlIG1lbW9yeSBpbiBvbmxp
bmUgc3RhdGUNCj4gPiAgICAgICAgICAgdHJ5aW5nIHRvIG9mZmxpbmUgNCBvdXQgb2YgMTkyIG1l
bW9yeSBibG9jayhzKToNCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MA0KPiA+IG9ubGluZS0+
b2ZmbGluZSBtZW1vcnkxMA0KPiA+IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMDANCj4gPiBvbmxp
bmUtPm9mZmxpbmUgbWVtb3J5MTAxDQo+ID4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTEwMg0KPiA+
IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMDMNCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTA0
DQo+ID4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTEwNQ0KPiA+IG9ubGluZS0+b2ZmbGluZSBtZW1v
cnkxMDYNCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTA3DQo+ID4gb25saW5lLT5vZmZsaW5l
IG1lbW9yeTEwOA0KPiA+IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMDkNCj4gPiBvbmxpbmUtPm9m
ZmxpbmUgbWVtb3J5MTENCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTEwDQo+ID4gb25saW5l
LT5vZmZsaW5lIG1lbW9yeTExMQ0KPiA+IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTINCj4gPiBv
bmxpbmUtPm9mZmxpbmUgbWVtb3J5MTEzDQo+ID4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTExNA0K
PiA+IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTUNCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5
MTE2DQo+ID4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTExNw0KPiA+IG9ubGluZS0+b2ZmbGluZSBt
ZW1vcnkxMTgNCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTE5DQo+ID4gb25saW5lLT5vZmZs
aW5lIG1lbW9yeTEyDQo+ID4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTEyMA0KPiA+IG9ubGluZS0+
b2ZmbGluZSBtZW1vcnkxMjENCj4gPiBvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTIyDQo+ID4gb25s
aW5lLT5vZmZsaW5lIG1lbW9yeTEyMw0KPiA+IG9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMjQNCj4g
DQo+IENhbiB3ZSBoYXZlIGhlcmUgYW4gb3V0cHV0IGxpa2UNCj4gDQo+IG9ubGluZS0+b2ZmbGlu
ZSBtZW1vcnkwDQo+IC0+IEZhaWx1cmUNCj4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTEwDQo+IC0+
IFN1Y2Nlc3MNCj4gDQo+IFRoYXQgd291bGQgbWFrZSBtdWNoIG1vcmUgc2Vuc2UgZm9yIGRlYnVn
Z2luZyBwdXJwb3NlcyBhbmQgdW5kZXJzdGFuZGluZw0KPiB3aGF0IGlzIGhhcHBlbmluZyBoZXJl
LiBJIHdhcyBwcmltYXJpbHkgY29uY2VybmVkIGFib3V0IHRoZSBtaXNsZWFkaW5nIGVycm9yDQo+
IG1lc3NhZ2UsIHRoYXQgaW5kaWNhdGVkIHRoYXQgc29tZXRoaW5nIGlzICJ1bmV4cGVjdGVkIiAt
LSBpdCdzIHBlcmZlY3RseQ0KPiByZWFzb25hYmxlIGhlcmUgdG8gKmV4cGVjdCogdGhhdCBvZmZs
aW5pbmcgYSByYW5kb20gbWVtb3J5IGJsb2NrcyBqdXN0IGZhaWxzLg0KDQpZZXMsIEkgd2lsbCBz
dWJtaXQgYSBuZXcgdmVyc2lvbiBvZiBwYXRjaGVzIHRvIGltcGxlbWVudCBpdCBhcyB5b3VyIHN1
Z2dlc3Rpb25lczoNCg0KMS4gIFJlZGlyZWN0IG1pc2xlYWRpbmcgbXNnIHRvIC9kZXYvbnVsbA0K
Mi4gIEFkZCBhbiBvdXRwdXQgZm9yIG9ubGluZS0+b2ZmbGluZSB0ZXN0DQoNClRoYW5rcyENCg0K
DQo+IA0KPiAtLQ0KPiBUaGFua3MsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==
