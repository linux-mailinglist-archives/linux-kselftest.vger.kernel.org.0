Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E629058EE0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiHJORo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJORn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 10:17:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178872840;
        Wed, 10 Aug 2022 07:17:41 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2sQP6CYmz6801v;
        Wed, 10 Aug 2022 22:14:53 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 16:17:38 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 10 Aug 2022 16:17:38 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 06/10] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Thread-Topic: [PATCH v9 06/10] bpf: Add bpf_lookup_*_key() and bpf_key_put()
 kfuncs
Thread-Index: AQHYq/aiv2FrGYb3YUqVNEfDGH76Tq2nDDGAgAEi+HA=
Date:   Wed, 10 Aug 2022 14:17:38 +0000
Message-ID: <ecc84dd76f4c429bb55e6bd8fece376b@huawei.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-7-roberto.sassu@huawei.com>
 <2b1d62ad-af4b-4694-ecc8-639fbd821a05@iogearbox.net>
In-Reply-To: <2b1d62ad-af4b-4694-ecc8-639fbd821a05@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.144.193]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBEYW5pZWwgQm9ya21hbm4gW21haWx0bzpkYW5pZWxAaW9nZWFyYm94Lm5ldF0NCj4g
U2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTAsIDIwMjIgMTI6NTMgQU0NCj4gT24gOC85LzIyIDM6
NDUgUE0sIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gQWRkIHRoZSBicGZfbG9va3VwX3VzZXJf
a2V5KCksIGJwZl9sb29rdXBfc3lzdGVtX2tleSgpIGFuZCBicGZfa2V5X3B1dCgpDQo+ID4ga2Z1
bmNzLCB0byByZXNwZWN0aXZlbHkgc2VhcmNoIGEga2V5IHdpdGggYSBnaXZlbiBzZXJpYWwgYW5k
IGZsYWdzLCBvYnRhaW4NCj4gPiBhIGtleSBmcm9tIGEgcHJlLWRldGVybWluZWQgSUQgZGVmaW5l
ZCBpbiBpbmNsdWRlL2xpbnV4L3ZlcmlmaWNhdGlvbi5oLCBhbmQNCj4gPiBjbGVhbnVwLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWku
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9icGYuaCAgICAgIHwgICA2ICsrDQo+
ID4gICBrZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgfCAxNTENCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE1NyBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBiL2luY2x1
ZGUvbGludXgvYnBmLmgNCj4gPiBpbmRleCAwZDU2YzIzY2M1MDQuLjU2NGI5ZTBiOGMxNiAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9icGYuaA0KPiA+IEBAIC0yNTcyLDQgKzI1NzIsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIGJw
Zl9jZ3JvdXBfYXR5cGVfZ2V0KHUzMg0KPiBhdHRhY2hfYnRmX2lkLCBpbnQgY2dyb3VwX2F0eXBl
KSB7fQ0KPiA+ICAgc3RhdGljIGlubGluZSB2b2lkIGJwZl9jZ3JvdXBfYXR5cGVfcHV0KGludCBj
Z3JvdXBfYXR5cGUpIHt9DQo+ID4gICAjZW5kaWYgLyogQ09ORklHX0JQRl9MU00gKi8NCj4gPg0K
PiA+ICsjaWZkZWYgQ09ORklHX0tFWVMNCj4gPiArc3RydWN0IGJwZl9rZXkgew0KPiA+ICsJc3Ry
dWN0IGtleSAqa2V5Ow0KPiA+ICsJYm9vbCB2YWxpZF9wdHI7DQo+ID4gK307DQo+ID4gKyNlbmRp
ZiAvKiBDT05GSUdfS0VZUyAqLw0KPiA+ICAgI2VuZGlmIC8qIF9MSU5VWF9CUEZfSCAqLw0KPiA+
IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYnBm
X3RyYWNlLmMNCj4gPiBpbmRleCA2OGU1Y2RkMjRjZWYuLjMzY2E0Y2ZlNmUyNiAxMDA2NDQNCj4g
PiAtLS0gYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4gPiArKysgYi9rZXJuZWwvdHJhY2Uv
YnBmX3RyYWNlLmMNCj4gPiBAQCAtMjAsNiArMjAsNyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4
L2Zwcm9iZS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2JzZWFyY2guaD4NCj4gPiAgICNpbmNs
dWRlIDxsaW51eC9zb3J0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9rZXkuaD4NCj4gPg0KPiA+
ICAgI2luY2x1ZGUgPG5ldC9icGZfc2tfc3RvcmFnZS5oPg0KPiA+DQo+ID4gQEAgLTExODEsNiAr
MTE4MiwxNTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBicGZfZnVuY19wcm90bw0KPiBicGZfZ2V0
X2Z1bmNfYXJnX2NudF9wcm90byA9IHsNCj4gPiAgIAkuYXJnMV90eXBlCT0gQVJHX1BUUl9UT19D
VFgsDQo+ID4gICB9Ow0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfS0VZUw0KPiA+ICtfX2RpYWdf
cHVzaCgpOw0KPiA+ICtfX2RpYWdfaWdub3JlX2FsbCgiLVdtaXNzaW5nLXByb3RvdHlwZXMiLA0K
PiA+ICsJCSAgImtmdW5jcyB3aGljaCB3aWxsIGJlIHVzZWQgaW4gQlBGIHByb2dyYW1zIik7DQo+
ID4gKw0KPiA+ICsvKioNCj4gPiArICogYnBmX2xvb2t1cF91c2VyX2tleSAtIGxvb2t1cCBhIGtl
eSBieSBpdHMgc2VyaWFsDQo+ID4gKyAqIEBzZXJpYWw6IGtleSBzZXJpYWwNCj4gPiArICogQGZs
YWdzOiBsb29rdXAtc3BlY2lmaWMgZmxhZ3MNCj4gPiArICoNCj4gPiArICogU2VhcmNoIGEga2V5
IHdpdGggYSBnaXZlbiAqc2VyaWFsKiBhbmQgdGhlIHByb3ZpZGVkICpmbGFncyouIFRoZQ0KPiA+
ICsgKiByZXR1cm5lZCBrZXksIGlmIGZvdW5kLCBoYXMgdGhlIHJlZmVyZW5jZSBjb3VudCBpbmNy
ZW1lbnRlZCBieQ0KPiA+ICsgKiBvbmUsIGFuZCBpcyBzdG9yZWQgaW4gYSBicGZfa2V5IHN0cnVj
dHVyZSwgcmV0dXJuZWQgdG8gdGhlIGNhbGxlci4NCj4gPiArICogVGhlIGJwZl9rZXkgc3RydWN0
dXJlIG11c3QgYmUgcGFzc2VkIHRvIGJwZl9rZXlfcHV0KCkgd2hlbiBkb25lDQo+ID4gKyAqIHdp
dGggaXQsIHNvIHRoYXQgdGhlIGtleSByZWZlcmVuY2UgY291bnQgaXMgZGVjcmVtZW50ZWQgYW5k
IHRoZQ0KPiA+ICsgKiBicGZfa2V5IHN0cnVjdHVyZSBpcyBmcmVlZC4NCj4gPiArICoNCj4gPiAr
ICogUGVybWlzc2lvbiBjaGVja3MgYXJlIGRlZmVycmVkIHRvIHRoZSB0aW1lIHRoZSBrZXkgaXMg
dXNlZCBieQ0KPiA+ICsgKiBvbmUgb2YgdGhlIGF2YWlsYWJsZSBrZXktc3BlY2lmaWMga2Z1bmNz
Lg0KPiA+ICsgKg0KPiA+ICsgKiBTZXQgKmZsYWdzKiB3aXRoIDEsIHRvIGF0dGVtcHQgY3JlYXRp
bmcgYSByZXF1ZXN0ZWQgc3BlY2lhbA0KPiA+ICsgKiBrZXlyaW5nIChlLmcuIHNlc3Npb24ga2V5
cmluZyksIGlmIGl0IGRvZXNuJ3QgeWV0IGV4aXN0LiBTZXQNCj4gPiArICogKmZsYWdzKiB3aXRo
IDIgdG8gbG9va3VwIGEga2V5IHdpdGhvdXQgd2FpdGluZyBmb3IgdGhlIGtleQ0KPiA+ICsgKiBj
b25zdHJ1Y3Rpb24sIGFuZCB0byByZXRyaWV2ZSB1bmluc3RhbnRpYXRlZCBrZXlzIChrZXlzIHdp
dGhvdXQNCj4gPiArICogZGF0YSBhdHRhY2hlZCB0byB0aGVtKS4NCj4gPiArICoNCj4gPiArICog
UmV0dXJuOiBhIGJwZl9rZXkgcG9pbnRlciB3aXRoIGEgdmFsaWQga2V5IHBvaW50ZXIgaWYgdGhl
IGtleSBpcyBmb3VuZCwgYQ0KPiA+ICsgKiAgICAgICAgIE5VTEwgcG9pbnRlciBvdGhlcndpc2Uu
DQo+ID4gKyAqLw0KPiA+ICtub2lubGluZSBfX3dlYWsgc3RydWN0IGJwZl9rZXkgKmJwZl9sb29r
dXBfdXNlcl9rZXkodTMyIHNlcmlhbCwgdTY0IGZsYWdzKQ0KPiANCj4gV2h5IHRoZSBuZWVkIGZv
ciBub2lubGluZSBhbmQgdGhlIF9fd2VhayBoZXJlIGFuZCBiZWxvdz8gKElmIGluZGVlZCBuZWVk
ZWQNCj4gdGhpcw0KPiBzaG91bGQgcHJvYmFibHkgYmUgZXhwbGFpbmVkIGluIHRoZSBjb21taXQg
ZGVzYy4pDQoNCk9oLCBJIHRvb2sgZnJvbSB2MyBvZiBLUCdzIHBhdGNoIHNldC4gSXQgaXMgZ29u
ZSBpbiB2NS4gV2lsbCBkbw0KdGhlIHNhbWUgYXMgd2VsbC4NCg0KPiA+ICt7DQo+ID4gKwlrZXlf
cmVmX3Qga2V5X3JlZjsNCj4gPiArCXN0cnVjdCBicGZfa2V5ICpia2V5Ow0KPiA+ICsNCj4gPiAr
CS8qIEtlZXAgaW4gc3luYyB3aXRoIGluY2x1ZGUvbGludXgva2V5LmguICovDQo+ID4gKwlpZiAo
ZmxhZ3MgPiAoS0VZX0xPT0tVUF9QQVJUSUFMIDw8IDEpIC0gMSkNCj4gDQo+IENhbid0IHdlIGp1
c3Qgc2ltcGxpZnkgYW5kIHRlc3QgZmxhZ3MgJg0KPiB+KEtFWV9MT09LVVBfQ1JFQVRFfEtFWV9M
T09LVVBfUEFSVElBTCk/DQoNCkkgdGhvdWdodCBhcyBpZiB3ZSBoYXZlIG1hbnkgZmxhZ3MuDQoN
Cj4gPiArCQlyZXR1cm4gTlVMTDsNCj4gPiArDQo+ID4gKwkvKiBQZXJtaXNzaW9uIGNoZWNrIGlz
IGRlZmVycmVkIHVudGlsIGFjdHVhbCBrZnVuYyB1c2luZyB0aGUga2V5LiAqLw0KPiA+ICsJa2V5
X3JlZiA9IGxvb2t1cF91c2VyX2tleShzZXJpYWwsIGZsYWdzLCBLRVlfREVGRVJfUEVSTV9DSEVD
Syk7DQo+ID4gKwlpZiAoSVNfRVJSKGtleV9yZWYpKQ0KPiA+ICsJCXJldHVybiBOVUxMOw0KPiA+
ICsNCj4gPiArCWJrZXkgPSBrbWFsbG9jKHNpemVvZigqYmtleSksIEdGUF9LRVJORUwpOw0KPiA+
ICsJaWYgKCFia2V5KSB7DQo+ID4gKwkJa2V5X3B1dChrZXlfcmVmX3RvX3B0cihrZXlfcmVmKSk7
DQo+ID4gKwkJcmV0dXJuIGJrZXk7DQo+IA0KPiBuaXQ6IGp1c3QgcmV0dXJuIE5VTEwgcHJvYmFi
bHkgY2xlYW5lcg0KDQpPay4NCg0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWJrZXktPmtleSA9IGtl
eV9yZWZfdG9fcHRyKGtleV9yZWYpOw0KPiA+ICsJYmtleS0+dmFsaWRfcHRyID0gdHJ1ZTsNCj4g
DQo+IG5pdDogSSdkIHByb2JhYmx5IHJlbmFtZSBzL3ZhbGlkX3B0ci9oYXNfcmVmLy4NCg0KT2su
DQoNCj4gPiArCXJldHVybiBia2V5Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICog
YnBmX2xvb2t1cF9zeXN0ZW1fa2V5IC0gbG9va3VwIGEga2V5IGJ5IGEgc3lzdGVtLWRlZmluZWQg
SUQNCj4gPiArICogQGlkOiBrZXkgSUQNCj4gPiArICoNCj4gPiArICogT2J0YWluIGEgYnBmX2tl
eSBzdHJ1Y3R1cmUgd2l0aCBhIGtleSBwb2ludGVyIHNldCB0byB0aGUgcGFzc2VkIGtleSBJRC4N
Cj4gPiArICogVGhlIGtleSBwb2ludGVyIGlzIG1hcmtlZCBhcyBpbnZhbGlkLCB0byBwcmV2ZW50
IGJwZl9rZXlfcHV0KCkgZnJvbQ0KPiA+ICsgKiBhdHRlbXB0aW5nIHRvIGRlY3JlbWVudCB0aGUg
a2V5IHJlZmVyZW5jZSBjb3VudCBvbiB0aGF0IHBvaW50ZXIuIFRoZSBrZXkNCj4gPiArICogcG9p
bnRlciBzZXQgaW4gc3VjaCB3YXkgaXMgY3VycmVudGx5IHVuZGVyc3Rvb2Qgb25seSBieQ0KPiA+
ICsgKiB2ZXJpZnlfcGtjczdfc2lnbmF0dXJlKCkuDQo+ID4gKyAqDQo+ID4gKyAqIFNldCAqaWQq
IHRvIG9uZSBvZiB0aGUgdmFsdWVzIGRlZmluZWQgaW4gaW5jbHVkZS9saW51eC92ZXJpZmljYXRp
b24uaDoNCj4gPiArICogMCBmb3IgdGhlIHByaW1hcnkga2V5cmluZyAoaW1tdXRhYmxlIGtleXJp
bmcgb2Ygc3lzdGVtIGtleXMpOyAxIGZvciBib3RoDQo+ID4gKyAqIHRoZSBwcmltYXJ5IGFuZCBz
ZWNvbmRhcnkga2V5cmluZyAod2hlcmUga2V5cyBjYW4gYmUgYWRkZWQgb25seSBpZiB0aGV5DQo+
ID4gKyAqIGFyZSB2b3VjaGVkIGZvciBieSBleGlzdGluZyBrZXlzIGluIHRob3NlIGtleXJpbmdz
KTsgMiBmb3IgdGhlIHBsYXRmb3JtDQo+ID4gKyAqIGtleXJpbmcgKHByaW1hcmlseSB1c2VkIGJ5
IHRoZSBpbnRlZ3JpdHkgc3Vic3lzdGVtIHRvIHZlcmlmeSBhIGtleGVjJ2VkDQo+ID4gKyAqIGtl
cm5lZCBpbWFnZSBhbmQsIHBvc3NpYmx5LCB0aGUgaW5pdHJhbWZzIHNpZ25hdHVyZSkuDQo+ID4g
KyAqDQo+ID4gKyAqIFJldHVybjogYSBicGZfa2V5IHBvaW50ZXIgd2l0aCBhbiBpbnZhbGlkIGtl
eSBwb2ludGVyIHNldCBmcm9tIHRoZQ0KPiA+ICsgKiAgICAgICAgIHByZS1kZXRlcm1pbmVkIElE
IG9uIHN1Y2Nlc3MsIGEgTlVMTCBwb2ludGVyIG90aGVyd2lzZQ0KPiA+ICsgKi8NCj4gPiArbm9p
bmxpbmUgX193ZWFrIHN0cnVjdCBicGZfa2V5ICpicGZfbG9va3VwX3N5c3RlbV9rZXkodTY0IGlk
KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYnBmX2tleSAqYmtleTsNCj4gPiArDQo+ID4gKwkvKiBL
ZWVwIGluIHN5bmMgd2l0aCBkZWZzIGluIGluY2x1ZGUvbGludXgvdmVyaWZpY2F0aW9uLmguICov
DQo+ID4gKwlpZiAoaWQgPiAodW5zaWduZWQgbG9uZylWRVJJRllfVVNFX1BMQVRGT1JNX0tFWVJJ
TkcpDQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4gKw0KPiA+ICsJYmtleSA9IGttYWxsb2Moc2l6
ZW9mKCpia2V5KSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBuaXQ6IENhbid0IHRoaXMgYmUgR0ZQX0FU
T01JQz8gVGhlbiBicGZfbG9va3VwX3N5c3RlbV9rZXkgZG9lc24ndCBuZWVkDQo+IEtGX1NMRUVQ
QUJMRQ0KPiBhdHRyaWJ1dGUsIGZ3aXcuIE92ZXJhbGwsIHRoZSBicGZfbG9va3VwX3tzeXN0ZW0s
dXNlcn1fa2V5KCkgbG9vayByZWFzb25hYmxlLg0KDQpPaywgd2lsbCBkby4NCg0KVGhhbmtzDQoN
ClJvYmVydG8NCg0KPiA+ICsJaWYgKCFia2V5KQ0KPiA+ICsJCXJldHVybiBia2V5Ow0KPiA+ICsN
Cj4gPiArCWJrZXktPmtleSA9IChzdHJ1Y3Qga2V5ICopKHVuc2lnbmVkIGxvbmcpaWQ7DQo+ID4g
Kwlia2V5LT52YWxpZF9wdHIgPSBmYWxzZTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gYmtleTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGJwZl9rZXlfcHV0IC0gZGVjcmVtZW50IGtl
eSByZWZlcmVuY2UgY291bnQgaWYga2V5IGlzIHZhbGlkIGFuZCBmcmVlDQo+IGJwZl9rZXkNCj4g
PiArICogQGJrZXk6IGJwZl9rZXkgc3RydWN0dXJlDQo+ID4gKyAqDQo+ID4gKyAqIERlY3JlbWVu
dCB0aGUgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBrZXkgaW5zaWRlICpia2V5KiwgaWYgdGhlIHBv
aW50ZXINCj4gPiArICogaXMgdmFsaWQsIGFuZCBmcmVlICpia2V5Ki4NCj4gPiArICovDQo+ID4g
K25vaW5saW5lIF9fd2VhayB2b2lkIGJwZl9rZXlfcHV0KHN0cnVjdCBicGZfa2V5ICpia2V5KQ0K
PiA+ICt7DQo+ID4gKwlpZiAoYmtleS0+dmFsaWRfcHRyKQ0KPiA+ICsJCWtleV9wdXQoYmtleS0+
a2V5KTsNCj4gPiArDQo+ID4gKwlrZnJlZShia2V5KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArX19k
aWFnX3BvcCgpOw0KPiA+ICsNCj4gPiArQlRGX1NFVDhfU1RBUlQoa2V5X2tmdW5jX3NldCkNCj4g
PiArQlRGX0lEX0ZMQUdTKGZ1bmMsIGJwZl9sb29rdXBfdXNlcl9rZXksIEtGX0FDUVVJUkUgfCBL
Rl9SRVRfTlVMTCB8DQo+IEtGX1NMRUVQQUJMRSkNCj4gPiArQlRGX0lEX0ZMQUdTKGZ1bmMsIGJw
Zl9sb29rdXBfc3lzdGVtX2tleSwNCj4gPiArCSAgICAgS0ZfQUNRVUlSRSB8IEtGX1JFVF9OVUxM
IHwgS0ZfU0xFRVBBQkxFKQ0KPiA+ICtCVEZfSURfRkxBR1MoZnVuYywgYnBmX2tleV9wdXQsIEtG
X1JFTEVBU0UpDQo+ID4gK0JURl9TRVQ4X0VORChrZXlfa2Z1bmNfc2V0KQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBidGZfa2Z1bmNfaWRfc2V0IGJwZl9rZXlfa2Z1bmNfc2V0ID0g
ew0KPiA+ICsJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ID4gKwkuc2V0ID0gJmtleV9rZnVuY19z
ZXQsDQo+ID4gK307DQo+ID4gKyNlbmRpZiAvKiBDT05GSUdfS0VZUyAqLw0KPiA+ICsNCj4gPiAr
Y29uc3Qgc3RydWN0IGJ0Zl9rZnVuY19pZF9zZXQgKmtmdW5jX3NldHNbXSA9IHsNCj4gPiArI2lm
ZGVmIENPTkZJR19LRVlTDQo+ID4gKwkmYnBmX2tleV9rZnVuY19zZXQsDQo+ID4gKyNlbmRpZiAv
KiBDT05GSUdfS0VZUyAqLw0KPiA+ICt9Ow0K
