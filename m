Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC245EEF43
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiI2HjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiI2HjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 03:39:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9212756C;
        Thu, 29 Sep 2022 00:39:10 -0700 (PDT)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MdQCH14DKzpVSB;
        Thu, 29 Sep 2022 15:36:11 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 15:39:08 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Thu, 29 Sep 2022 15:39:08 +0800
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
Thread-Index: AdjT1byUgPM4MSRHq0+s99zfeKpZsg==
Date:   Thu, 29 Sep 2022 07:39:08 +0000
Message-ID: <f16e94ec925747f3954d34aa4bd0c355@huawei.com>
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

SGksDQoNCldlIGNhbiBub3QgZ2V0IHRoZSBFQlVTWSBmcm9tICIgZWNobyAwID4gL3N5cy9kZXZp
Y2VzL3N5c3RlbS9tZW1vcnkvbWVtb3J5eHh4L29ubGluZSIsIG1heWJlLCByZWRpcmVjdCB0aGUg
ZXJyb3Igb3VwdXQgdG8gL2Rldi9udWxsIGlzIHN1aXRhYmxlIHdoZW4gY2FsbGluZyBvZmZsaW5l
X21lbW9yeV9leHBlY3Rfc3VjY2VzcygpOg0KDQojIHNoIG1lbS1vbi1vZmYtdGVzdC5zaCAtYQ0K
bWVtLW9uLW9mZi10ZXN0LnNoOiBpbGxlZ2FsIG9wdGlvbiAtLSBhDQpUZXN0IHNjb3BlOiAyJSBo
b3RwbHVnIG1lbW9yeQ0KICAgICAgICAgb25saW5lIGFsbCBob3QtcGx1Z2dhYmxlIG1lbW9yeSBp
biBvZmZsaW5lIHN0YXRlOg0KICAgICAgICAgICAgICAgICBTS0lQUEVEIC0gbm8gaG90LXBsdWdn
YWJsZSBtZW1vcnkgaW4gb2ZmbGluZSBzdGF0ZQ0KICAgICAgICAgb2ZmbGluZSAyJSBob3QtcGx1
Z2dhYmxlIG1lbW9yeSBpbiBvbmxpbmUgc3RhdGUNCiAgICAgICAgIHRyeWluZyB0byBvZmZsaW5l
IDQgb3V0IG9mIDE5MiBtZW1vcnkgYmxvY2socyk6DQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MA0K
b25saW5lLT5vZmZsaW5lIG1lbW9yeTEwDQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTAwDQpvbmxp
bmUtPm9mZmxpbmUgbWVtb3J5MTAxDQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTAyDQpvbmxpbmUt
Pm9mZmxpbmUgbWVtb3J5MTAzDQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTA0DQpvbmxpbmUtPm9m
ZmxpbmUgbWVtb3J5MTA1DQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTA2DQpvbmxpbmUtPm9mZmxp
bmUgbWVtb3J5MTA3DQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTA4DQpvbmxpbmUtPm9mZmxpbmUg
bWVtb3J5MTA5DQpvbmxpbmUtPm9mZmxpbmUgbWVtb3J5MTENCm9ubGluZS0+b2ZmbGluZSBtZW1v
cnkxMTANCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTENCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkx
MTINCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTMNCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTQN
Cm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTUNCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTYNCm9u
bGluZS0+b2ZmbGluZSBtZW1vcnkxMTcNCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMTgNCm9ubGlu
ZS0+b2ZmbGluZSBtZW1vcnkxMTkNCm9ubGluZS0+b2ZmbGluZSBtZW1vcnkxMg0Kb25saW5lLT5v
ZmZsaW5lIG1lbW9yeTEyMA0Kb25saW5lLT5vZmZsaW5lIG1lbW9yeTEyMQ0Kb25saW5lLT5vZmZs
aW5lIG1lbW9yeTEyMg0Kb25saW5lLT5vZmZsaW5lIG1lbW9yeTEyMw0Kb25saW5lLT5vZmZsaW5l
IG1lbW9yeTEyNA0KICAgICAgICAgb25saW5lIGFsbCBob3QtcGx1Z2dhYmxlIG1lbW9yeSBpbiBv
ZmZsaW5lIHN0YXRlOg0Kb2ZmbGluZS0+b25saW5lIG1lbW9yeTEyMQ0Kb2ZmbGluZS0+b25saW5l
IG1lbW9yeTEyMg0Kb2ZmbGluZS0+b25saW5lIG1lbW9yeTEyMw0Kb2ZmbGluZS0+b25saW5lIG1l
bW9yeTEyNA0KICAgICAgICAgVGVzdCB3aXRoIG1lbW9yeSBub3RpZmllciBlcnJvciBpbmplY3Rp
b24NCiMgZWNobyAkPw0KMA0KDQpUaGFua3MhDQpHb25neWkNCg0KDQo+IA0KPiANCj4gPj4gUmV2
aWV3ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiA+Pg0KPiA+
Pg0KPiA+PiBJIGFtIHF1ZXN0aW9uaW5nIHRoZSBzdGFiaWxpdHkgb2YgdGhlIG9mZmxpbmluZyB0
ZXN0LCB0aG91Z2guDQo+ID4+IE9mZmxpbmluZyBhIHJhbmRvbSBtZW1vcnkgYmxvY2sgY2FuIGZh
aWwgZWFzaWx5LCBiZWNhdXNlDQo+ID4+ICItPnJlbW92YWJsZSIgaXMgbm90DQo+ID4+IGV4cHJl
c3NpdmU6DQo+ID4+DQo+ID4+ICMgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5LWhvdHBs
dWcvbWVtLW9uLW9mZi10ZXN0LnNoDQo+ID4+IFRlc3Qgc2NvcGU6IDIlIGhvdHBsdWcgbWVtb3J5
DQo+ID4+ICAgICAgICAgICAgb25saW5lIGFsbCBob3QtcGx1Z2dhYmxlIG1lbW9yeSBpbiBvZmZs
aW5lIHN0YXRlOg0KPiA+PiAgICAgICAgICAgICAgICAgICAgU0tJUFBFRCAtIG5vIGhvdC1wbHVn
Z2FibGUgbWVtb3J5IGluIG9mZmxpbmUgc3RhdGUNCj4gPj4gICAgICAgICAgICBvZmZsaW5lIDIl
IGhvdC1wbHVnZ2FibGUgbWVtb3J5IGluIG9ubGluZSBzdGF0ZQ0KPiA+PiAgICAgICAgICAgIHRy
eWluZyB0byBvZmZsaW5lIDIgb3V0IG9mIDk2IG1lbW9yeSBibG9jayhzKToNCj4gPj4gb25saW5l
LT5vZmZsaW5lIG1lbW9yeTANCj4gPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWVtb3J5LWhv
dHBsdWcvbWVtLW9uLW9mZi10ZXN0LnNoOiBsaW5lIDc4OiBlY2hvOg0KPiA+PiB3cml0ZSBlcnJv
cjogSW52YWxpZCBhcmd1bWVudCBvZmZsaW5lX21lbW9yeV9leHBlY3Rfc3VjY2VzcyAwOg0KPiA+
PiB1bmV4cGVjdGVkIGZhaWwNCj4gPj4gb25saW5lLT5vZmZsaW5lIG1lbW9yeTEwDQo+ID4+IG9u
bGluZS0+b2ZmbGluZSBtZW1vcnkxMQ0KPiA+Pg0KPiA+Pg0KPiA+PiBJIGd1ZXNzIHRoaXMgdGVz
dCB3aWxsIGFsbW9zdCBhbHdheXMgZmFpbCBub3dhZGF5cy4NCj4gPg0KPiA+IE9mZmxpbmUgc29t
ZSBtZW1vcnkgbm9kZSBtYXliZSBmYWlsZWQgYXMgZXhwZWN0ZWQsIGJ1dCB0aGUgZXJyb3IgbWVz
c2FnZQ0KPiBpcyBhIGJpdCBhbm5veWluZy4NCj4gDQo+IEFoLCBJIHNlZSBpdCBub3cuIFdlIHRy
eSBvZmZsaW5pbmcgdHdvIGFuZCBmYWlsIG9mZmxpbmluZyB0aGUgZmlyc3Qgb25lLg0KPiBDYW4g
d2Ugc2lsZW5jZSB0aGF0IHdhcm5pbmcgaW4gdGhhdCBjYXNlIHNvbWVob3c/DQo+IA0KPiAtLQ0K
PiBUaGFua3MsDQo+IA0KPiBEYXZpZCAvIGRoaWxkZW5iDQoNCg==
