Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F358EED1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiHJOwn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbiHJOwm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 10:52:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCADF74CF8;
        Wed, 10 Aug 2022 07:52:40 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2tFt5ZZZz67y8S;
        Wed, 10 Aug 2022 22:52:34 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 16:52:38 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 10 Aug 2022 16:52:38 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
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
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: RE: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark a
 function to be sleepable
Thread-Topic: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark
 a function to be sleepable
Thread-Index: AQHYq/aDa3kCDLsk5EK6T80CaXl/sK2mqA6AgAF8nfD//+wHAIAAA64AgAAlKhA=
Date:   Wed, 10 Aug 2022 14:52:38 +0000
Message-ID: <294f7bc395a04a129703a522c42d021e@huawei.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-2-roberto.sassu@huawei.com>
 <YvKRYRjJdXbAWL6Y@kernel.org> <c9e73d7aa51a47c585b935a41dbf1924@huawei.com>
 <CAO-hwJLNsV00pEcTY65TBNszCTh1DfhidK+m5NULiwtGr7GLmw@mail.gmail.com>
 <e807779b-e72b-e197-b833-43373e87d3df@iogearbox.net>
In-Reply-To: <e807779b-e72b-e197-b833-43373e87d3df@iogearbox.net>
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
U2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTAsIDIwMjIgNDozOSBQTQ0KPiBPbiA4LzEwLzIyIDQ6
MjUgUE0sIEJlbmphbWluIFRpc3NvaXJlcyB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAxMCwgMjAy
MiBhdCAzOjQ0IFBNIFJvYmVydG8gU2Fzc3UNCj4gPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4g
d3JvdGU6DQo+ID4+PiBGcm9tOiBKYXJra28gU2Fra2luZW4gW21haWx0bzpqYXJra29Aa2VybmVs
Lm9yZ10NCj4gPj4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDY6NTUgUE0NCj4gPj4+
IE9uIFR1ZSwgQXVnIDA5LCAyMDIyIGF0IDAzOjQ1OjU0UE0gKzAyMDAsIFJvYmVydG8gU2Fzc3Ug
d3JvdGU6DQo+ID4+Pj4gRnJvbTogQmVuamFtaW4gVGlzc29pcmVzIDxiZW5qYW1pbi50aXNzb2ly
ZXNAcmVkaGF0LmNvbT4NCj4gPj4+Pg0KPiA+Pj4+IEZyb206IEJlbmphbWluIFRpc3NvaXJlcyA8
YmVuamFtaW4udGlzc29pcmVzQHJlZGhhdC5jb20+DQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGFsbG93
cyB0byBkZWNsYXJlIGEga2Z1bmMgYXMgc2xlZXBhYmxlIGFuZCBwcmV2ZW50cyBpdHMgdXNlIGlu
DQo+ID4+Pj4gYSBub24gc2xlZXBhYmxlIHByb2dyYW0uDQo+ID4+Pg0KPiA+Pj4gTml0OiAiRGVj
bGFyZSBhIGtmdW5jIGFzIHNsZWVwYWJsZSBhbmQgcHJldmVudCBpdHMgdXNlIGluIGENCj4gPj4+
IG5vbi1zbGVlcGFibGUgcHJvZ3JhbS4iDQo+ID4+Pg0KPiA+Pj4gSXQncyBtaXNzaW5nIHRoZSBw
YXJ0ICpob3cqIHRoZSBwYXRjaCBhY2NvbXBsaXNoZXMgaXRzIGdvYWxzLg0KPiA+Pg0KPiA+PiBJ
IHdpbGwgYWRkOg0KPiA+Pg0KPiA+PiBJZiBhbiBlQlBGIHByb2dyYW0gaXMgZ29pbmcgdG8gY2Fs
bCBhIGtmdW5jIGRlY2xhcmVkIGFzIHNsZWVwYWJsZSwNCj4gPj4gZUJQRiB3aWxsIGxvb2sgYXQg
dGhlIGVCUEYgcHJvZ3JhbSBmbGFncy4gSWYgQlBGX0ZfU0xFRVBBQkxFIGlzDQo+ID4+IG5vdCBz
ZXQsIGV4ZWN1dGlvbiBvZiB0aGF0IHByb2dyYW0gaXMgZGVuaWVkLg0KPiA+DQo+ID4gQWxsIHRo
b3NlIGNoYW5nZXMgYXJlIGxvb2tpbmcgZ29vZCB0byBtZS4NCj4gPg0KPiA+IFRoYW5rcyBhIGxv
dCBmb3Iga2VlcGluZyBwdXNoaW5nIG9uIHRoaXMgcGF0Y2ggOikNCj4gDQo+IFRoaXMgc2luZ2xl
IG9uZSBmcm9tIHRoZSBzZXJpZXMgZ290IGFscmVhZHkgYXBwbGllZCBoZXJlOg0KPiANCj4gICAg
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnBmL2JwZi0N
Cj4gbmV4dC5naXQvY29tbWl0Lz9pZD1mYTk2YjI0MjA0YWY0MjI3NGVjMTNkZmIyZjJlNjk5MGQ3
NTEwZTU1DQoNCk9rLCBub3cgSSB1bmRlcnN0b29kIHRoZSBtZXJnZSBtZXNzYWdlIGJldHRlci4N
Cg0KUm9iZXJ0bw0KDQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gVGlzc29pcmVzIDxi
ZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT4NCj4gPj4+PiBDby1kZXZlbG9wZWQtYnk6IFlv
c3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTog
WW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5
OiBIYW8gTHVvIDxoYW9sdW9AZ29vZ2xlLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgIERvY3Vt
ZW50YXRpb24vYnBmL2tmdW5jcy5yc3QgfCA2ICsrKysrKw0KPiA+Pj4+ICAgaW5jbHVkZS9saW51
eC9idGYuaCAgICAgICAgICB8IDEgKw0KPiA+Pj4+ICAga2VybmVsL2JwZi9idGYuYyAgICAgICAg
ICAgICB8IDkgKysrKysrKysrDQo+ID4+Pj4gICAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKykNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2JwZi9rZnVu
Y3MucnN0IGIvRG9jdW1lbnRhdGlvbi9icGYva2Z1bmNzLnJzdA0KPiA+Pj4+IGluZGV4IGMwYjdk
YWU2ZGJmNS4uYzhiMjFkZTFjNzcyIDEwMDY0NA0KPiA+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24v
YnBmL2tmdW5jcy5yc3QNCj4gPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2JwZi9rZnVuY3MucnN0
DQo+ID4+Pj4gQEAgLTE0Niw2ICsxNDYsMTIgQEAgdGhhdCBvcGVyYXRlIChjaGFuZ2Ugc29tZSBw
cm9wZXJ0eSwgcGVyZm9ybQ0KPiBzb21lDQo+ID4+PiBvcGVyYXRpb24pIG9uIGFuIG9iamVjdCB0
aGF0DQo+ID4+Pj4gICB3YXMgb2J0YWluZWQgdXNpbmcgYW4gYWNxdWlyZSBrZnVuYy4gU3VjaCBr
ZnVuY3MgbmVlZCBhbiB1bmNoYW5nZWQNCj4gcG9pbnRlcg0KPiA+Pj4gdG8NCj4gPj4+PiAgIGVu
c3VyZSB0aGUgaW50ZWdyaXR5IG9mIHRoZSBvcGVyYXRpb24gYmVpbmcgcGVyZm9ybWVkIG9uIHRo
ZSBleHBlY3RlZA0KPiBvYmplY3QuDQo=
