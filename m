Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85F56A0B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jul 2022 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiGGLBE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Jul 2022 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGGLBD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Jul 2022 07:01:03 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4963357238;
        Thu,  7 Jul 2022 04:01:02 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LdtdT2f2lz688Kr;
        Thu,  7 Jul 2022 18:56:45 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 13:00:59 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 7 Jul 2022 13:00:59 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     KP Singh <kpsingh@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "kafai@fb.com" <kafai@fb.com>, "yhs@fb.com" <yhs@fb.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] bpf: Add bpf_verify_pkcs7_signature() helper
Thread-Topic: [PATCH v6 4/5] bpf: Add bpf_verify_pkcs7_signature() helper
Thread-Index: AQHYiuqGDtlDO2qp4UmZ/vpVUoStkK1xbJmAgACCGICAANf/YA==
Date:   Thu, 7 Jul 2022 11:00:58 +0000
Message-ID: <52aa81c8037640a7935cdfd6f363a07d@huawei.com>
References: <20220628122750.1895107-1-roberto.sassu@huawei.com>
 <20220628122750.1895107-5-roberto.sassu@huawei.com>
 <903b1b6c-b0fd-d624-a24b-5983d8d661b7@iogearbox.net>
 <CACYkzJ4iR=FurW2UZdgycTdu54kNoFrw4uvmDrpTd3xuvpvVTw@mail.gmail.com>
In-Reply-To: <CACYkzJ4iR=FurW2UZdgycTdu54kNoFrw4uvmDrpTd3xuvpvVTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBLUCBTaW5naCBbbWFpbHRvOmtwc2luZ2hAa2VybmVsLm9yZ10NCj4gU2VudDogVGh1
cnNkYXksIEp1bHkgNywgMjAyMiAxOjQ5IEFNDQo+IE9uIFdlZCwgSnVsIDYsIDIwMjIgYXQgNjow
NCBQTSBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0Pg0KPiB3cm90ZToNCj4g
Pg0KPiA+IE9uIDYvMjgvMjIgMjoyNyBQTSwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IEFk
ZCB0aGUgYnBmX3ZlcmlmeV9wa2NzN19zaWduYXR1cmUoKSBoZWxwZXIsIHRvIGdpdmUgZUJQRiBz
ZWN1cml0eSBtb2R1bGVzDQo+ID4gPiB0aGUgYWJpbGl0eSB0byBjaGVjayB0aGUgdmFsaWRpdHkg
b2YgYSBzaWduYXR1cmUgYWdhaW5zdCBzdXBwbGllZCBkYXRhLCBieQ0KPiA+ID4gdXNpbmcgdXNl
ci1wcm92aWRlZCBvciBzeXN0ZW0tcHJvdmlkZWQga2V5cyBhcyB0cnVzdCBhbmNob3IuDQo+ID4g
Pg0KPiA+ID4gVGhlIG5ldyBoZWxwZXIgbWFrZXMgaXQgcG9zc2libGUgdG8gZW5mb3JjZSBtYW5k
YXRvcnkgcG9saWNpZXMsIGFzIGVCUEYNCj4gPiA+IHByb2dyYW1zIG1pZ2h0IGJlIGFsbG93ZWQg
dG8gbWFrZSBzZWN1cml0eSBkZWNpc2lvbnMgb25seSBiYXNlZCBvbiBkYXRhDQo+ID4gPiBzb3Vy
Y2VzIHRoZSBzeXN0ZW0gYWRtaW5pc3RyYXRvciBhcHByb3Zlcy4NCj4gPiA+DQo+ID4gPiBUaGUg
Y2FsbGVyIHNob3VsZCBwcm92aWRlIGJvdGggdGhlIGRhdGEgdG8gYmUgdmVyaWZpZWQgYW5kIHRo
ZSBzaWduYXR1cmUgYXMNCj4gPiA+IGVCUEYgZHluYW1pYyBwb2ludGVycyAodG8gbWluaW1pemUg
dGhlIG51bWJlciBvZiBwYXJhbWV0ZXJzKS4NCj4gPiA+DQo+ID4gPiBUaGUgY2FsbGVyIHNob3Vs
ZCBhbHNvIHByb3ZpZGUgYSB0cnVzdGVkIGtleXJpbmcgc2VyaWFsLCB0b2dldGhlciB3aXRoIGtl
eQ0KPiA+ID4gbG9va3VwLXNwZWNpZmljIGZsYWdzLCB0byBkZXRlcm1pbmUgd2hpY2gga2V5cyBj
YW4gYmUgdXNlZCBmb3Igc2lnbmF0dXJlDQo+ID4gPiB2ZXJpZmljYXRpb24uIEFsdGVybmF0aXZl
bHksIHRoZSBjYWxsZXIgY291bGQgc3BlY2lmeSB6ZXJvIGFzIHNlcmlhbCB2YWx1ZQ0KPiA+ID4g
KG5vdCB2YWxpZCwgc2VyaWFscyBtdXN0IGJlIHBvc2l0aXZlKSwgYW5kIHByb3ZpZGUgaW5zdGVh
ZCBhIHNwZWNpYWwNCj4gPiA+IGtleXJpbmcgSUQuDQo+ID4gPg0KPiA+ID4gS2V5IGxvb2t1cCBm
bGFncyBhcmUgZGVmaW5lZCBpbiBpbmNsdWRlL2xpbnV4L2tleS5oIGFuZCBjYW4gYmU6IDEsIHRv
DQo+ID4gPiByZXF1ZXN0IHRoYXQgc3BlY2lhbCBrZXlyaW5ncyBiZSBjcmVhdGVkIGlmIHJlZmVy
cmVkIHRvIGRpcmVjdGx5OyAyIHRvDQo+ID4gPiBwZXJtaXQgcGFydGlhbGx5IGNvbnN0cnVjdGVk
IGtleXMgdG8gYmUgZm91bmQuDQo+ID4gPg0KPiA+ID4gU3BlY2lhbCBJRHMgYXJlIGRlZmluZWQg
aW4gaW5jbHVkZS9saW51eC92ZXJpZmljYXRpb24uaCBhbmQgY2FuIGJlOiAwIGZvcg0KPiA+ID4g
dGhlIHByaW1hcnkga2V5cmluZyAoaW1tdXRhYmxlIGtleXJpbmcgb2Ygc3lzdGVtIGtleXMpOyAx
IGZvciBib3RoIHRoZQ0KPiA+ID4gcHJpbWFyeSBhbmQgc2Vjb25kYXJ5IGtleXJpbmcgKHdoZXJl
IGtleXMgY2FuIGJlIGFkZGVkIG9ubHkgaWYgdGhleSBhcmUNCj4gPiA+IHZvdWNoZWQgZm9yIGJ5
IGV4aXN0aW5nIGtleXMgaW4gdGhvc2Uga2V5cmluZ3MpOyAyIGZvciB0aGUgcGxhdGZvcm0ga2V5
cmluZw0KPiA+ID4gKHByaW1hcmlseSB1c2VkIGJ5IHRoZSBpbnRlZ3JpdHkgc3Vic3lzdGVtIHRv
IHZlcmlmeSBhIGtleGVjJ2VkIGtlcm5lZA0KPiA+ID4gaW1hZ2UgYW5kLCBwb3NzaWJseSwgdGhl
IGluaXRyYW1mcyBzaWduYXR1cmUpLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmVy
dG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gPiA+IFJlcG9ydGVkLWJ5OiBr
ZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4gKGNhc3Qgd2FybmluZykNCj4gPg0KPiA+
IG5pdDogR2l2ZW4gdGhpcyBhIG5ldyBmZWF0dXJlIG5vdCBhIGZpeCB0byBleGlzdGluZyBjb2Rl
LCB0aGVyZSBpcyBubyBuZWVkIHRvDQo+ID4gICAgICAgYWRkIHRoZSBhYm92ZSByZXBvcnRlZC1i
eSBmcm9tIGtidWlsZCBib3QuDQoNCk9rLg0KDQo+ID4gPiAtLS0NCj4gPiA+ICAgaW5jbHVkZS91
YXBpL2xpbnV4L2JwZi5oICAgICAgIHwgMjQgKysrKysrKysrKysrKw0KPiA+ID4gICBrZXJuZWwv
YnBmL2JwZl9sc20uYyAgICAgICAgICAgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gPiAgIHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8IDI0ICsrKysr
KysrKysrKysNCj4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRl
L3VhcGkvbGludXgvYnBmLmgNCj4gPiA+IGluZGV4IGU4MTM2Mjg5MTU5Ni4uYjRmNWFkODYzMjgx
IDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oDQo+ID4gPiArKysg
Yi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4gPiA+IEBAIC01MzI1LDYgKzUzMjUsMjkgQEAg
dW5pb24gYnBmX2F0dHIgew0KPiA+ID4gICAgKiAgICAgICAgICAqKi1FQUNDRVMqKiBpZiB0aGUg
U1lOIGNvb2tpZSBpcyBub3QgdmFsaWQuDQo+ID4gPiAgICAqDQo+ID4gPiAgICAqICAgICAgICAg
ICoqLUVQUk9UT05PU1VQUE9SVCoqIGlmIENPTkZJR19JUFY2IGlzIG5vdCBidWlsdGluLg0KPiA+
ID4gKyAqDQo+ID4gPiArICogbG9uZyBicGZfdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZShzdHJ1Y3Qg
YnBmX2R5bnB0ciAqZGF0YV9wdHIsIHN0cnVjdA0KPiBicGZfZHlucHRyICpzaWdfcHRyLCB1MzIg
dHJ1c3RlZF9rZXlyaW5nX3NlcmlhbCwgdW5zaWduZWQgbG9uZyBsb29rdXBfZmxhZ3MsDQo+IHVu
c2lnbmVkIGxvbmcgdHJ1c3RlZF9rZXlyaW5nX2lkKQ0KPiA+DQo+ID4gbml0OiBmb3IgdGhlIGFy
Z3MgaW5zdGVhZCBvZiB1bG9uZywganVzdCBkbyB1NjQNCg0KT2suDQoNCj4gPiA+ICsgKiAgIERl
c2NyaXB0aW9uDQo+ID4gPiArICogICAgICAgICAgIFZlcmlmeSB0aGUgUEtDUyM3IHNpZ25hdHVy
ZSAqc2lnX3B0ciogYWdhaW5zdCB0aGUgc3VwcGxpZWQNCj4gPiA+ICsgKiAgICAgICAgICAgKmRh
dGFfcHRyKiB3aXRoIGtleXMgaW4gYSBrZXlyaW5nIHdpdGggc2VyaWFsDQo+ID4gPiArICogICAg
ICAgICAgICp0cnVzdGVkX2tleXJpbmdfc2VyaWFsKiwgc2VhcmNoZWQgd2l0aCAqbG9va3VwX2Zs
YWdzKiwgaWYgdGhlDQo+ID4gPiArICogICAgICAgICAgIHBhcmFtZXRlciB2YWx1ZSBpcyBwb3Np
dGl2ZSwgb3IgYWx0ZXJuYXRpdmVseSBpbiBhIGtleXJpbmcgd2l0aA0KPiA+ID4gKyAqICAgICAg
ICAgICBzcGVjaWFsIElEICp0cnVzdGVkX2tleXJpbmdfaWQqIGlmICp0cnVzdGVkX2tleXJpbmdf
c2VyaWFsKiBpcw0KPiA+ID4gKyAqICAgICAgICAgICB6ZXJvLg0KPiA+ID4gKyAqDQo+ID4gPiAr
ICogICAgICAgICAgICpsb29rdXBfZmxhZ3MqIGFyZSBkZWZpbmVkIGluIGluY2x1ZGUvbGludXgv
a2V5LmggYW5kIGNhbiBiZTogMSwNCj4gPiA+ICsgKiAgICAgICAgICAgdG8gcmVxdWVzdCB0aGF0
IHNwZWNpYWwga2V5cmluZ3MgYmUgY3JlYXRlZCBpZiByZWZlcnJlZCB0bw0KPiA+ID4gKyAqICAg
ICAgICAgICBkaXJlY3RseTsgMiB0byBwZXJtaXQgcGFydGlhbGx5IGNvbnN0cnVjdGVkIGtleXMg
dG8gYmUgZm91bmQuDQo+ID4gPiArICoNCj4gPiA+ICsgKiAgICAgICAgICAgU3BlY2lhbCBJRHMg
YXJlIGRlZmluZWQgaW4gaW5jbHVkZS9saW51eC92ZXJpZmljYXRpb24uaCBhbmQgY2FuDQo+ID4g
PiArICogICAgICAgICAgIGJlOiAwIGZvciB0aGUgcHJpbWFyeSBrZXlyaW5nIChpbW11dGFibGUg
a2V5cmluZyBvZiBzeXN0ZW0NCj4gPiA+ICsgKiAgICAgICAgICAga2V5cyk7IDEgZm9yIGJvdGgg
dGhlIHByaW1hcnkgYW5kIHNlY29uZGFyeSBrZXlyaW5nICh3aGVyZSBrZXlzDQo+ID4gPiArICog
ICAgICAgICAgIGNhbiBiZSBhZGRlZCBvbmx5IGlmIHRoZXkgYXJlIHZvdWNoZWQgZm9yIGJ5IGV4
aXN0aW5nIGtleXMgaW4NCj4gPiA+ICsgKiAgICAgICAgICAgdGhvc2Uga2V5cmluZ3MpOyAyIGZv
ciB0aGUgcGxhdGZvcm0ga2V5cmluZyAocHJpbWFyaWx5IHVzZWQgYnkNCj4gPiA+ICsgKiAgICAg
ICAgICAgdGhlIGludGVncml0eSBzdWJzeXN0ZW0gdG8gdmVyaWZ5IGEga2V4ZWMnZWQga2VybmVk
IGltYWdlIGFuZCwNCj4gPiA+ICsgKiAgICAgICAgICAgcG9zc2libHksIHRoZSBpbml0cmFtZnMg
c2lnbmF0dXJlKS4NCj4gPiA+ICsgKiAgIFJldHVybg0KPiA+ID4gKyAqICAgICAgICAgICAwIG9u
IHN1Y2Nlc3MsIGEgbmVnYXRpdmUgdmFsdWUgb24gZXJyb3IuDQo+ID4gPiAgICAqLw0KPiA+ID4g
ICAjZGVmaW5lIF9fQlBGX0ZVTkNfTUFQUEVSKEZOKSAgICAgICAgICAgICAgIFwNCj4gPiA+ICAg
ICAgIEZOKHVuc3BlYyksICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gQEAgLTU1MzUsNiAr
NTU1OCw3IEBAIHVuaW9uIGJwZl9hdHRyIHsNCj4gPiA+ICAgICAgIEZOKHRjcF9yYXdfZ2VuX3N5
bmNvb2tpZV9pcHY2KSwgXA0KPiA+ID4gICAgICAgRk4odGNwX3Jhd19jaGVja19zeW5jb29raWVf
aXB2NCksICAgICAgIFwNCj4gPiA+ICAgICAgIEZOKHRjcF9yYXdfY2hlY2tfc3luY29va2llX2lw
djYpLCAgICAgICBcDQo+ID4gPiArICAgICBGTih2ZXJpZnlfcGtjczdfc2lnbmF0dXJlKSwgICAg
IFwNCj4gPg0KPiA+IChOZWVkcyByZWJhc2UpDQo+ID4NCj4gPiA+ICAgICAgIC8qICovDQo+ID4g
Pg0KPiA+ID4gICAvKiBpbnRlZ2VyIHZhbHVlIGluICdpbW0nIGZpZWxkIG9mIEJQRl9DQUxMIGlu
c3RydWN0aW9uIHNlbGVjdHMgd2hpY2ggaGVscGVyDQo+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVs
L2JwZi9icGZfbHNtLmMgYi9rZXJuZWwvYnBmL2JwZl9sc20uYw0KPiA+ID4gaW5kZXggYzEzNTFk
ZjlmN2VlLi40MDFiZGEwMWFkODQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwvYnBmL2JwZl9s
c20uYw0KPiA+ID4gKysrIGIva2VybmVsL2JwZi9icGZfbHNtLmMNCj4gPiA+IEBAIC0xNiw2ICsx
Niw4IEBADQo+ID4gPiAgICNpbmNsdWRlIDxsaW51eC9icGZfbG9jYWxfc3RvcmFnZS5oPg0KPiA+
ID4gICAjaW5jbHVkZSA8bGludXgvYnRmX2lkcy5oPg0KPiA+ID4gICAjaW5jbHVkZSA8bGludXgv
aW1hLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3ZlcmlmaWNhdGlvbi5oPg0KPiA+ID4gKyNp
bmNsdWRlIDxsaW51eC9rZXkuaD4NCj4gPiA+DQo+ID4gPiAgIC8qIEZvciBldmVyeSBMU00gaG9v
ayB0aGF0IGFsbG93cyBhdHRhY2htZW50IG9mIEJQRiBwcm9ncmFtcywgZGVjbGFyZSBhDQo+IG5v
cA0KPiA+ID4gICAgKiBmdW5jdGlvbiB3aGVyZSBhIEJQRiBwcm9ncmFtIGNhbiBiZSBhdHRhY2hl
ZC4NCj4gPiA+IEBAIC0xMzIsNiArMTM0LDYyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnBmX2Z1
bmNfcHJvdG8NCj4gYnBmX2dldF9hdHRhY2hfY29va2llX3Byb3RvID0gew0KPiA+ID4gICAgICAg
LmFyZzFfdHlwZSAgICAgID0gQVJHX1BUUl9UT19DVFgsDQo+ID4gPiAgIH07DQo+ID4gPg0KPiA+
ID4gKyNpZmRlZiBDT05GSUdfU1lTVEVNX0RBVEFfVkVSSUZJQ0FUSU9ODQo+ID4gPiArQlBGX0NB
TExfNShicGZfdmVyaWZ5X3BrY3M3X3NpZ25hdHVyZSwgc3RydWN0IGJwZl9keW5wdHJfa2VybiAq
LA0KPiBkYXRhX3B0ciwNCj4gPiA+ICsgICAgICAgIHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKiwg
c2lnX3B0ciwgdTMyLCB0cnVzdGVkX2tleXJpbmdfc2VyaWFsLA0KPiA+ID4gKyAgICAgICAgdW5z
aWduZWQgbG9uZywgbG9va3VwX2ZsYWdzLCB1bnNpZ25lZCBsb25nLCB0cnVzdGVkX2tleXJpbmdf
aWQpDQo+ID4gPiArew0KPiA+ID4gKyAgICAga2V5X3JlZl90IHRydXN0ZWRfa2V5cmluZ19yZWY7
DQo+ID4gPiArICAgICBzdHJ1Y3Qga2V5ICp0cnVzdGVkX2tleXJpbmc7DQo+ID4gPiArICAgICBp
bnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgLyogS2VlcCBpbiBzeW5jIHdpdGggZGVmcyBp
biBpbmNsdWRlL2xpbnV4L2tleS5oLiAqLw0KPiA+ID4gKyAgICAgaWYgKGxvb2t1cF9mbGFncyA+
IEtFWV9MT09LVVBfUEFSVElBTCkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4NCj4gPiBpaXVjLCB0aGUgS0VZX0xPT0tVUF8qIGlzIGEgbWFzaywgc28geW91IGNvdWxk
IGFsc28gY29tYmluZSB0aGUgdHdvLCBlLmcuDQo+ID4gS0VZX0xPT0tVUF9DUkVBVEUgfCBLRVlf
TE9PS1VQX1BBUlRJQUwuIEkgaGF2ZW4ndCBzZWVuIHlvdQ0KPiBtZW50aW9uaW5nIGFueXRoaW5n
DQo+ID4gc3BlY2lmaWMgb24gd2h5IGl0IGlzIG5vdCBhbGxvd2VkLiBXaGF0J3MgdGhlIHJhdGlv
bmFsZSwgaWYgaXQncyBpbnRlbnRpb25hbA0KPiA+IGlmIHNob3VsZCBwcm9iYWJseSBiZSBkb2N1
bWVudGVkPw0KDQpJdCB3YXMgYSBtaXN0YWtlLiBXaWxsIGZpeCBpdC4NCg0KPiBJIHRoaW5rIHRo
aXMgd2FzIGEgcGFydCBvZiB0aGUgZGlnaWxpbSB0aHJlYXQgbW9kZWwgKG9ubHkgYWxsb3cNCj4g
bGltaXRlZCBsb29rdXAgb3BlcmF0aW9ucyksDQo+IGJ1dCB0aGlzIHNlZW1zIHRvIGJlIGNvbmZs
YXRpbmcgdGhlIHBvbGljeSBpbnRvIHRoZSBpbXBsZW1lbnRhdGlvbiBvZg0KPiB0aGUgaGVscGVy
Lg0KDQpVaG0sIHllcywgYnV0IHRoZXNlIGZsYWdzIHNob3VsZCBub3QgYWZmZWN0IHRoYXQgcmVx
dWlyZW1lbnQuDQoNCkFzIGxvbmcgYXMgSSBjYW4gc2VsZWN0IHRoZSBwcmltYXJ5IG9yIHNlY29u
ZGFyeSBrZXlyaW5nIHJlbGlhYmx5DQp3aXRoIHRoZSBwcmUtZGV0ZXJtaW5lZCBJRHMsIHRoYXQg
c2hvdWxkIGJlIGZpbmUuDQoNCj4gUm9iZXJ0bywgY2FuIHRoaXMgbm90IGJlIGltcGxlbWVudGVk
IGluIGRpZ2lsaW0gYXMgYSBCUEYgTFNNIGNoZWNrDQo+IHRoYXQgYXR0YWNoZXMgdG8gdGhlIGtl
eV9wZXJtaXNzaW9uIExTTSBob29rPw0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvaW5jbHVkZS9saQ0K
PiBudXgvbHNtX2hvb2tzLmgjbjExNTgNCg0KVGhlIHByZS1kZXRlcm1pbmVkIElEcyBoYW5kbGVk
IGJ5IHZlcmlmeV9wa2NzN19zaWduYXR1cmUoKSBhcmUNCm1vcmUgZWZmZWN0aXZlIGluIHNlbGVj
dGluZyB0aGUgcHJvcGVyIGtleS4NCg0KPiA+IEF0IG1pbmltdW0gSSBhbHNvIHRoaW5rIHRoZSBo
ZWxwZXIgZGVzY3JpcHRpb24gbmVlZHMgdG8gYmUgaW1wcm92ZWQgZm9yDQo+IHBlb3BsZQ0KPiA+
IHRvIHVuZGVyc3RhbmQgZW5vdWdoIHcvbyByZWFkaW5nIHRocm91Z2ggdGhlIGtlcm5lbCBzb3Vy
Y2UsIGUuZy4gd3J0DQo+IGxvb2t1cF9mbGFncw0KPiA+IHNpbmNlIEkgaGF2ZW4ndCBzZWVuIGl0
IGluIHlvdXIgc2VsZnRlc3RzIGVpdGhlciAuLi4gd2hlbiBkb2VzIGEgdXNlciBuZWVkIHRvDQo+
ID4gdXNlIHRoZSBnaXZlbiBmbGFncy4NCj4gPg0KPiA+IG5pdDogd2hlbiBib3RoIHRydXN0ZWRf
a2V5cmluZ19zZXJpYWwgYW5kIHRydXN0ZWRfa2V5cmluZ19pZCBhcmUgcGFzc2VkIHRvIHRoZQ0K
PiA+IGhlbHBlciwgdGhlbiB0aGlzIHNob3VsZCBiZSByZWplY3RlZCBhcyBpbnZhbGlkIGFyZ3Vt
ZW50PyAoS2luZCBvZiBmZWVscyBhIGJpdA0KPiA+IGxpa2Ugd2UncmUgY3JhbW1pbmcgdHdvIHRo
aW5ncyBpbiBvbmUgaGVscGVyLi4gS1AsIHRob3VnaHRzPyA6KSkNCj4gDQo+IEVJTlZBTCB3aGVu
IGJvdGggYXJlIHBhc3NlZCBzZWVtcyByZWFzb25hYmxlLiBUaGUgc2lnbmF0dXJlIChwdW4/KSBv
ZiB0aGUNCj4gZG9lcyBzZWVtIHRvIGdldCBibG9hdGVkLCBidXQgSSBhbSBub3Qgc3VyZSBpZiBp
dCdzIHdvcnRoIGFkZGluZyB0d28NCj4gaGVscGVycyBoZXJlLg0KDQpPayBmb3IgRUlOVkFMLiBT
aG91bGQgSSBjaGFuZ2UgdGhlIHRydXN0ZWRfa2V5cmluZ19pZCB0eXBlIHRvIHNpZ25lZCwNCmFu
ZCB1c2UgLTEgd2hlbiBpdCBzaG91bGQgbm90IGJlIHNwZWNpZmllZD8NCg0KVGhhbmtzDQoNClJv
YmVydG8NCg0KPiA+ID4gKyAgICAgLyogS2VlcCBpbiBzeW5jIHdpdGggZGVmcyBpbiBpbmNsdWRl
L2xpbnV4L3ZlcmlmaWNhdGlvbi5oLiAqLw0KPiA+ID4gKyAgICAgaWYgKHRydXN0ZWRfa2V5cmlu
Z19pZCA+ICh1bnNpZ25lZA0KPiBsb25nKVZFUklGWV9VU0VfUExBVEZPUk1fS0VZUklORykNCj4g
PiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gPiArICAgICBp
ZiAodHJ1c3RlZF9rZXlyaW5nX3NlcmlhbCkgew0KPiA+ID4gKyAgICAgICAgICAgICB0cnVzdGVk
X2tleXJpbmdfcmVmID0gbG9va3VwX3VzZXJfa2V5KHRydXN0ZWRfa2V5cmluZ19zZXJpYWwsDQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bG9va3VwX2ZsYWdzLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEtFWV9ORUVEX1NFQVJDSCk7DQo+ID4gPiArICAgICAgICAgICAgIGlm
IChJU19FUlIodHJ1c3RlZF9rZXlyaW5nX3JlZikpDQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIFBUUl9FUlIodHJ1c3RlZF9rZXlyaW5nX3JlZik7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgICAgICAgIHRydXN0ZWRfa2V5cmluZyA9IGtleV9yZWZfdG9fcHRyKHRydXN0ZWRfa2V5
cmluZ19yZWYpOw0KPiA+ID4gKyAgICAgICAgICAgICBnb3RvIHZlcmlmeTsNCj4gPiA+ICsgICAg
IH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgIHRydXN0ZWRfa2V5cmluZyA9IChzdHJ1Y3Qga2V5ICop
dHJ1c3RlZF9rZXlyaW5nX2lkOw0KPiA+ID4gK3ZlcmlmeToNCj4gPiA+ICsgICAgIHJldCA9IHZl
cmlmeV9wa2NzN19zaWduYXR1cmUoZGF0YV9wdHItPmRhdGEsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJwZl9keW5wdHJfZ2V0X3NpemUoZGF0YV9wdHIpLA0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaWdfcHRyLT5kYXRhLA0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicGZfZHlucHRyX2dldF9zaXpl
KHNpZ19wdHIpLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVz
dGVkX2tleXJpbmcsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZF
UklGWUlOR19VTlNQRUNJRklFRF9TSUdOQVRVUkUsIE5VTEwsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KPiA+ID4gKyAgICAgaWYgKHRydXN0ZWRfa2V5
cmluZ19zZXJpYWwpDQo+ID4gPiArICAgICAgICAgICAgIGtleV9wdXQodHJ1c3RlZF9rZXlyaW5n
KTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJldHVybiByZXQ7DQo+ID4gPiArfQ0KPiA+ID4gKw0K
PiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8gYnBmX3ZlcmlmeV9wa2Nz
N19zaWduYXR1cmVfcHJvdG8gPSB7DQo+ID4gPiArICAgICAuZnVuYyAgICAgICAgICAgPSBicGZf
dmVyaWZ5X3BrY3M3X3NpZ25hdHVyZSwNCj4gPiA+ICsgICAgIC5ncGxfb25seSAgICAgICA9IGZh
bHNlLA0KPiA+ID4gKyAgICAgLnJldF90eXBlICAgICAgID0gUkVUX0lOVEVHRVIsDQo+ID4gPiAr
ICAgICAuYXJnMV90eXBlICAgICAgPSBBUkdfUFRSX1RPX0RZTlBUUiB8IERZTlBUUl9UWVBFX0xP
Q0FMLA0KPiA+ID4gKyAgICAgLmFyZzJfdHlwZSAgICAgID0gQVJHX1BUUl9UT19EWU5QVFIgfCBE
WU5QVFJfVFlQRV9MT0NBTCwNCj4gPiA+ICsgICAgIC5hcmczX3R5cGUgICAgICA9IEFSR19BTllU
SElORywNCj4gPiA+ICsgICAgIC5hcmc0X3R5cGUgICAgICA9IEFSR19BTllUSElORywNCj4gPiA+
ICsgICAgIC5hcmc1X3R5cGUgICAgICA9IEFSR19BTllUSElORywNCj4gPiA+ICsgICAgIC5hbGxv
d2VkICAgICAgICA9IGJwZl9pbWFfaW5vZGVfaGFzaF9hbGxvd2VkLA0KPiA+ID4gK307DQo+ID4g
PiArI2VuZGlmIC8qIENPTkZJR19TWVNURU1fREFUQV9WRVJJRklDQVRJT04gKi8NCj4gPiA+ICsN
Cg==
