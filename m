Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FEC5B9702
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIOJHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIOJHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 05:07:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772879351F;
        Thu, 15 Sep 2022 02:07:15 -0700 (PDT)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MSrrQ2sh4zBsL7;
        Thu, 15 Sep 2022 17:05:10 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 17:07:13 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Thu, 15 Sep 2022 17:07:13 +0800
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
Subject: Re: [PATCH -next 4/5] selftests/memory-hotplug: Restore memory before
 exit
Thread-Topic: [PATCH -next 4/5] selftests/memory-hotplug: Restore memory
 before exit
Thread-Index: AdjI4di+jDtB2yhWTra18n09UshJEw==
Date:   Thu, 15 Sep 2022 09:07:13 +0000
Message-ID: <a87ac52f279b4bc3944c57f135d8c03c@huawei.com>
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

SGksDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIEkgaGF2ZSBzdWJtaXQgdGhlIHBhdGNoZXMg
aW4gYSBuZXcgdmVyc2lvbiBhcyB5b3VyIHN1Z2dlc3Rpb24uDQoNCkJlc3QgV2lzaGVzLA0KR29u
Z3lpDQoNCj4gDQo+IE9uIDA5LjA5LjIyIDA5OjUxLCBaaGFvIEdvbmd5aSB3cm90ZToNCj4gPiBT
b21lIG1vbW9yeSB3aWxsIGJlIGxlZnQgaW4gb2ZmbGluZSBzdGF0ZSB3aGVuIGNhbGxpbmcNCj4g
PiBvZmZsaW5lX21lbW9yeV9leHBlY3RfZmFpbCgpIGZhaWxlZC4gUmVzdG9yZSBpdCBiZWZvcmUg
ZXhpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW8gR29uZ3lpIDx6aGFvZ29uZ3lpQGh1
YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vbWVtb3J5LWhvdHBsdWcvbWVtLW9uLW9mZi10
ZXN0LnNoICAgICAgICAgfCAyNA0KPiArKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tZW1vcnktaG90cGx1Zy9tZW0tb24tb2Zm
LXRlc3Quc2gNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21l
bS1vbi1vZmYtdGVzdC5zaA0KPiA+IGluZGV4IDNiZGYzYzRkNmQwNi4uMjU5ZmQ4OTc4NjM5IDEw
MDc1NQ0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9yeS1ob3RwbHVnL21l
bS1vbi1vZmYtdGVzdC5zaA0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21lbW9y
eS1ob3RwbHVnL21lbS1vbi1vZmYtdGVzdC5zaA0KPiA+IEBAIC0xMzQsNiArMTM0LDE3IEBAIG9m
ZmxpbmVfbWVtb3J5X2V4cGVjdF9mYWlsKCkNCj4gPiAgIAlyZXR1cm4gMA0KPiA+ICAgfQ0KPiA+
DQo+ID4gK29ubGluZV9hbGxfaG90X3BsdWdnYWJsZV9tZW1vcnkoKQ0KPiA+ICt7DQo+ID4gKw0K
PiA+ICsJZm9yIG1lbW9yeSBpbiBgaG90cGx1Z2dhYmxlX29mZmxpbmVfbWVtb3J5YDsgZG8NCj4g
PiArCQlvbmxpbmVfbWVtb3J5X2V4cGVjdF9zdWNjZXNzICRtZW1vcnkgfHwgew0KPiA+ICsJCQll
Y2hvICJvbmxpbmUgbWVtb3J5ICRtZW1vcnk6IHVuZXhwZWN0ZWQgZmFpbCINCj4gPiArCQkJcmV0
dmFsPTENCj4gPiArCQl9DQo+ID4gKwlkb25lDQo+ID4gK30NCj4gDQo+IE1heWJlIGNhbGwgaXQN
Cj4gDQo+ICJvbmxpbmVfYWxsX29mZmxpbmVfbWVtb3J5KCkiDQo+IA0KPiBpbnN0ZWFkPw0KPiAN
Cj4gTm90ZSB0aGF0ICJyZW1vdmFibGUiIGFzIHVzZWQgaW4gaG90cGx1Z2dhYmxlX21lbW9yeSgp
IHdpbGwgbm93YWRheXMNCj4gYWx3YXlzIHJldHVybiAiMSIgaWYgdGhlIGtlcm5lbCBzdXBwb3J0
cyBtZW1vcnkgaG90dW5wbHVnLCBpbmRlcGVuZGVudA0KPiBvZiB0aGUgc3BlY2lmaWMgbWVtb3J5
IGJsb2NrLg0KPiANCj4gLS0NCj4gVGhhbmtzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=
