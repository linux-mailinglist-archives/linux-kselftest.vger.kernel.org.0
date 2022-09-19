Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2852B5BC4E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiISJBo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiISJBm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 05:01:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D41C135;
        Mon, 19 Sep 2022 02:01:40 -0700 (PDT)
Received: from canpemm100006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWJT64862zMn2F;
        Mon, 19 Sep 2022 16:56:58 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100006.china.huawei.com (7.192.104.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 17:01:38 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031;
 Mon, 19 Sep 2022 17:01:38 +0800
From:   zhaogongyi <zhaogongyi@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "shuah@kernel.org" <shuah@kernel.org>
Subject: Re: [PATCH -next v2 1/5] docs: notifier-error-inject: fix non-working
 usage of negative values
Thread-Topic: [PATCH -next v2 1/5] docs: notifier-error-inject: fix
 non-working usage of negative values
Thread-Index: AdjMBWnu287D6MO2SCOsmHrOPTOinw==
Date:   Mon, 19 Sep 2022 09:01:38 +0000
Message-ID: <076b1f2a38ab4ca4a61e6a79c765bcba@huawei.com>
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

SGkhDQoNCj4gDQo+IE9uIDE3LjA5LjIyIDA3OjM5LCBBa2lub2J1IE1pdGEgd3JvdGU6DQo+ID4g
MjAyMuW5tDnmnIgxNeaXpSjmnKgpIDE4OjAxIFpoYW8gR29uZ3lpIDx6aGFvZ29uZ3lpQGh1YXdl
aS5jb20+Og0KPiA+Pg0KPiA+PiBGYXVsdCBpbmplY3Rpb24gdXNlcyBkZWJ1Z2ZzIGluIGEgd2F5
IHRoYXQgdGhlIHByb3ZpZGVkIHZhbHVlcyB2aWENCj4gPj4gc3lzZnMgYXJlIGludGVycHJldGVk
IGFzIHU2NC4gUHJvdmlkaW5nIG5lZ2F0aXZlIG51bWJlcnMgcmVzdWx0cyBpbg0KPiA+PiBhbiBl
cnJvcjoNCj4gPj4NCj4gPj4gICAgIyBjZCBzeXMva2VybmVsL2RlYnVnL25vdGlmaWVyLWVycm9y
LWluamVjdC9tZW1vcnkNCj4gPj4gICAgIyAgZWNobyAtMTIgPiBhY3Rpb25zL01FTV9HT0lOR19P
TkxJTkUvZXJyb3INCj4gPj4gICAgLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBJbnZhbGlkIGFy
Z3VtZW50DQo+ID4+DQo+ID4+IFVwZGF0ZSB0aGUgZG9jcyBhbmQgZXhhbXBsZXMgdG8gdXNlICJw
cmludGYgJSN4IDx2YWw+IiBpbiB0aGVzZSBjYXNlcy4NCj4gPg0KPiA+IEknZCByYXRoZXIgZml4
IHRoZSBub3RpZmllci1lcnJvci1pbmplY3QgbW9kdWxlIHRoYW4gY2hhbmdlIHRoZSB1c2VyDQo+
IGludGVyZmFjZS4NCj4gPiBJJ2xsIHNlbmQgYSBwYXRjaCwgc28gY291bGQgeW91IGNoZWNrIGlm
IHRoYXQgc29sdmVzIHRoZSBwcm9ibGVtLg0KPiA+DQo+IA0KPiBUaGF0IHdpbGwgYWxzbyBtYWtl
IHBhdGNoICMyIHVubmVjZXNzYXJ5LCBjb3JyZWN0Pw0KDQpZZXMuIEJ1dCB0aGVyZSBpcyBhbm90
aGVyIGNvbW1pdCAwMDU3NDc1MjZkNGYzYzJlYzk5NTg5MWU5NWNiNzYyNTE2MTAyMmY5IHRoYXQg
aGFzIHRoZSBzYW1lIHByb2JsZW0uDQoNClRoYW5rcyENCg0KPiANCj4gLS0NCj4gVGhhbmtzLA0K
PiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=
