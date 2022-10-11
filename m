Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3175D5FAA4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Oct 2022 03:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJKBsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKBsU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 21:48:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F06D578;
        Mon, 10 Oct 2022 18:48:19 -0700 (PDT)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmdqD65v0zVhpK;
        Tue, 11 Oct 2022 09:43:52 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 09:48:17 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Tue, 11 Oct 2022 09:48:17 +0800
From:   zhaogongyi <zhaogongyi@huawei.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
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
Thread-Index: AdjdE3momxHH4sO5SHuE6BL6lEWgMA==
Date:   Tue, 11 Oct 2022 01:48:17 +0000
Message-ID: <004ae09e8f0848cdb993aac309b71ece@huawei.com>
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

SGkgU2h1YWgsIERhdmlkLA0KDQpJIGFtIHNvcnJ5IGZvciBteSBzbG93IHJlc3BvbnNlLCBJIGhh
dmUgc3VibWl0IGEgbmV3IHBhdGNoIHRvIGZpeCBpdC4gUGxlYXNlIHNlZTogaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWtzZWxmdGVzdC9wYXRjaC8yMDIyMTAxMTAx
MzkyNi4yMDA3NzQtMS16aGFvZ29uZ3lpQGh1YXdlaS5jb20vDQoNClRoYW5rcywNCkdvbmd5aQ0K
DQo+IA0KPiBPbiAxMC8xMC8yMiAwMDo1NCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+ID4g
T24gMDguMTAuMjIgMDM6NDAsIHpoYW9nb25neWkgd3JvdGU6DQo+IA0KPiA+Pg0KPiA+PiBZZXMs
IG9ubGluZV9tZW1vcnlfZXhwZWN0X3N1Y2Nlc3MoKSBhbHJlYWR5IHByaW50cyBhIHdhcm5pbmcs
DQo+IHJlbW92ZQ0KPiA+PiB0aGUgd2FybmluZyBpbiBvbmxpbmVfYWxsX29mZmxpbmVfbWVtb3J5
KCkgc2VlbXMgb2ssDQo+ID4+DQo+ID4+IE15IHByZXZpb3VzIGNvbnNpZGVyYXRpb24gd2FzIHRo
YXQgb25lIG1vcmUgbG9nIGluZm9ybWF0aW9uIHdvdWxkDQo+IG1ha2UgaXQgZWFzaWVyIHRvIGxv
Y2F0ZSB0aGUgd3JvbmcgbG9jYXRpb24uDQo+ID4NCj4gPiBMZXQncyBrZWVwIGl0IHNpbXBsZSB1
bmxlc3MgdGhlcmUgaXMgcmVhbCByZWFzb24gdG8gd2FybiB0d2ljZS4NCj4gPg0KPiANCj4gemhh
b2dvbmd5aSwNCj4gDQo+IFBsZWFzZSBub3RlIHRoYXQgSSBhbHJlYWR5IGFwcGxpZWQgdGhlIHBh
dGNoZXMgdG8gbGludXgta3NlbGZ0ZXN0IG5leHQgZm9yIG15DQo+IHNlY29uZCBwdWxsIHJlcXVl
c3QgYmVmb3JlIHRoZSBtZXJnZSB3aW5kb3cuIFBsZWFzZSBzZW5kIHRoZSBjaGFuZ2UNCj4gRGF2
aWQgcmVxdWVzdGVkIGluIGEgc2VwYXJhdGUgcGF0Y2ggb24gdG9wIG9mIG5leHQgYXMgYSBmaXgu
DQo+IA0KPiB0aGFua3MsDQo+IC0tIFNodWFoDQo=
