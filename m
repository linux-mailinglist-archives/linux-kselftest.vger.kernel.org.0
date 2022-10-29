Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1BD6122E2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 14:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ2MXm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Oct 2022 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ2MXi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Oct 2022 08:23:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888244D835
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Oct 2022 05:23:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-193-yOyJapxqNr6g5VWDcEBcsw-1; Sat, 29 Oct 2022 13:23:34 +0100
X-MC-Unique: yOyJapxqNr6g5VWDcEBcsw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 29 Oct
 2022 13:23:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Sat, 29 Oct 2022 13:23:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rong Tao' <rtoax@foxmail.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "haoluo@google.com" <haoluo@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "mykolal@fb.com" <mykolal@fb.com>,
        "rongtao@cestc.cn" <rongtao@cestc.cn>,
        "sdf@google.com" <sdf@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>
Subject: RE: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Thread-Topic: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Thread-Index: AQHY60Mk36Wn0FfjTU6Muu9w9hWY+64lSbUw
Date:   Sat, 29 Oct 2022 12:23:33 +0000
Message-ID: <1611fe67d311461aa5f820836318bacc@AcuMS.aculab.com>
References: <CAEf4BzazYVkVKrKzPD8a7tRZrcWDvvgoVksJHYk3+46V=8kZhw@mail.gmail.com>
 <tencent_BA460110770C008560B21A2E3555405E9F09@qq.com>
In-Reply-To: <tencent_BA460110770C008560B21A2E3555405E9F09@qq.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogUm9uZyBUYW8NCj4gU2VudDogMjkgT2N0b2JlciAyMDIyIDA0OjAwDQo+IA0KPiBGcm9t
OiBSb25nIFRhbyA8cm9uZ3Rhb0BjZXN0Yy5jbj4NCj4gDQo+IFJlcGxhY2Ugc3RybmNweSgpIHdp
dGggc3RybmNhdCgpLCBzdHJuY2F0KCkgbGVhdmVzIHRoZSBkc3Qgc3RyaW5nIHplcm8NCj4gdGVy
bWluYXRlZC4gQ29tcGlsZSBzYW1wbGVzL2JwZiB3YXJuaW5nOg0KDQpUaGlzIG9ubHkgbWFrZXMg
YSBkaWZmZXJlbmNlIGJlY2F1c2UgdGVzdHMgZm9yIHN0cm5jYXQoKSBoYXZlIG5vdCBiZWVuIGFk
ZGVkLg0Kc3J0bmNhdCgpIHJlYWxseSBpcyBuZXZlciB0aGUgc3RyaW5nIGZ1bmN0aW9uIHlvdSBh
cmUgbG9va2luZyBmb3IuDQoNCglEYXZpZA0KDQoNCj4gDQo+ICQgY2Qgc2FtcGxlcy9icGYNCj4g
JCBtYWtlDQo+IC4uLg0KPiBJbiBmdW5jdGlvbiDigJhfX2VuYWJsZV9jb250cm9sbGVyc+KAmToN
Cj4gc2FtcGxlcy9icGYvLi4vLi4vdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Nncm91cF9o
ZWxwZXJzLmM6ODA6MTc6IHdhcm5pbmc6IOKAmHN0cm5jcHnigJkgc3BlY2lmaWVkDQo+IGJvdW5k
IDQwOTcgZXF1YWxzIGRlc3RpbmF0aW9uIHNpemUgWy1Xc3RyaW5nb3AtdHJ1bmNhdGlvbl0NCj4g
ICAgODAgfCAgICAgICAgICAgICAgICAgc3RybmNweShlbmFibGUsIGNvbnRyb2xsZXJzLCBzaXpl
b2YoZW5hYmxlKSk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb25nIFRh
byA8cm9uZ3Rhb0BjZXN0Yy5jbj4NCj4gLS0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvY2dyb3VwX2hlbHBlcnMuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL2Nncm91cF9oZWxwZXJzLmMNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvY2dyb3VwX2hlbHBlcnMuYw0KPiBpbmRleCBhNzBlODczYjI2N2UuLjkxMmU2NTIyYzdj
NSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Nncm91cF9oZWxw
ZXJzLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Nncm91cF9oZWxwZXJz
LmMNCj4gQEAgLTc3LDcgKzc3LDggQEAgc3RhdGljIGludCBfX2VuYWJsZV9jb250cm9sbGVycyhj
b25zdCBjaGFyICpjZ3JvdXBfcGF0aCwgY29uc3QgY2hhciAqY29udHJvbGxlcnMNCj4gIAkJZW5h
YmxlW2xlbl0gPSAwOw0KPiAgCQljbG9zZShmZCk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJc3RybmNw
eShlbmFibGUsIGNvbnRyb2xsZXJzLCBzaXplb2YoZW5hYmxlKSAtIDEpOw0KPiArCQllbmFibGVb
MF0gPSAnXDAnOw0KPiArCQlzdHJuY2F0KGVuYWJsZSwgY29udHJvbGxlcnMsIHNpemVvZihlbmFi
bGUpIC0gMSk7DQo+ICAJfQ0KPiANCj4gIAlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICIl
cy9jZ3JvdXAuc3VidHJlZV9jb250cm9sIiwgY2dyb3VwX3BhdGgpOw0KPiAtLQ0KPiAyLjMxLjEN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

