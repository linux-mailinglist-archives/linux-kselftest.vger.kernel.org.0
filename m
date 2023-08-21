Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF697829EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjHUNFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjHUNFK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 09:05:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D988F
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 06:05:08 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-193-2ku7-XKJNSuRNmkn66H0_Q-1; Mon, 21 Aug 2023 14:05:06 +0100
X-MC-Unique: 2ku7-XKJNSuRNmkn66H0_Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Aug
 2023 14:04:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 21 Aug 2023 14:04:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: RE: [PATCH 1/2] selftests: Provide local define of min() and max()
Thread-Topic: [PATCH 1/2] selftests: Provide local define of min() and max()
Thread-Index: AQHZ03nFpJJs9cS/jEaiicM+CY14+6/0t4aQ
Date:   Mon, 21 Aug 2023 13:04:54 +0000
Message-ID: <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
 <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiBTdW5kYXksIEF1Z3VzdCAyMCwgMjAyMyA0
OjE1IFBNDQo+IA0KPiBNYWhtb3VkIE1hYXR1cSB3cm90ZToNCj4gPiB0byBhdm9pZCBtYW51YWwg
Y2FsY3VsYXRpb24gb2YgbWluIGFuZCBtYXggdmFsdWVzDQo+ID4gYW5kIGZpeCBjb2NjaW5lbGxl
IHdhcm5pbmdzIHN1Y2ggV0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWluKCkvbWF4KCkNCj4gPiBh
ZGRpbmcgb25lIGNvbW1vbiBkZWZpbml0aW9uIHRoYXQgY291bGQgYmUgdXNlZCBpbiBtdWx0aXBs
ZSBmaWxlcw0KPiA+IHVuZGVyIHNlbGZ0ZXN0cy4NCj4gPiB0aGVyZSBhcmUgYWxzbyBzb21lIGRl
ZmluZXMgZm9yIG1pbi9tYXggc2NhdHRlcmVkIGxvY2FsbHkgaW5zaWRlIHNvdXJjZXMNCj4gPiB1
bmRlciBzZWxmdGVzdHMuDQo+ID4gdGhpcyBhbHNvIHByZXBhcmVzIGZvciBjbGVhbmluZyB1cCB0
aG9zZSByZWR1bmRhbnQgZGVmaW5lcyBhbmQgaW5jbHVkZQ0KPiA+IGtzZWxmdGVzdC5oIGluc3Rl
YWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYWhtb3VkIE1hYXR1cSA8bWFobW91ZG1hdG9v
ay5tbUBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tz
ZWxmdGVzdC5oIHwgNyArKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRl
c3QuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC5oDQo+ID4gaW5kZXggODI5
YmUzNzk1NDVhLi5lOGViN2U5YWZiYzYgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMva3NlbGZ0ZXN0LmgNCj4gPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9r
c2VsZnRlc3QuaA0KPiA+IEBAIC01NSw2ICs1NSwxMyBAQA0KPiA+ICAjZGVmaW5lIEFSUkFZX1NJ
WkUoYXJyKSAoc2l6ZW9mKGFycikgLyBzaXplb2YoKGFycilbMF0pKQ0KPiA+ICAjZW5kaWYNCj4g
Pg0KPiA+ICsjaWZuZGVmIG1pbg0KPiA+ICsjIGRlZmluZSBtaW4oeCwgeSkgKCh4KSA8ICh5KSA/
ICh4KSA6ICh5KSkNCj4gPiArI2VuZGlmDQo+ID4gKyNpZm5kZWYgbWF4DQo+ID4gKyMgZGVmaW5l
IG1heCh4LCB5KSAoKHgpIDwgKHkpID8gKHkpIDogKHgpKQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+
IA0KPiBTaG91bGQgdGhpcyBtb3JlIGNsb3NlbHkgZm9sbG93IGluY2x1ZGUvbGludXgvbWlubWF4
LmgsIHdoaWNoIGlzIGEgbG90DQo+IG1vcmUgc3RyaWN0Pw0KPiANCj4gSSdtIGZpbmUgd2l0aCB0
aGlzIHNpbXBsZXIsIG1vcmUgcmVsYXhlZCwgdmVyc2lvbiBmb3IgdGVzdGluZywgYnV0DQo+IGNh
bGxpbmcgaXQgb3V0IGZvciBwZW9wbGUgdG8gc3BlYWsgdXAuDQo+IA0KPiBPbmx5IHRoZSBmaXJz
dCB0d28gb2YgdGhlc2UgY29tbWVudHMgaW4gbWlubWF4LmggYXBwbHkgdG8gdGhpcw0KPiB1c2Vy
c3BhY2UgY29kZS4NCj4gDQo+IC8qDQo+ICAqIG1pbigpL21heCgpL2NsYW1wKCkgbWFjcm9zIG11
c3QgYWNjb21wbGlzaCB0aHJlZSB0aGluZ3M6DQo+ICAqDQo+ICAqIC0gYXZvaWQgbXVsdGlwbGUg
ZXZhbHVhdGlvbnMgb2YgdGhlIGFyZ3VtZW50cyAoc28gc2lkZS1lZmZlY3RzIGxpa2UNCj4gICog
ICAieCsrIiBoYXBwZW4gb25seSBvbmNlKSB3aGVuIG5vbi1jb25zdGFudC4NCj4gICogLSBwZXJm
b3JtIHN0cmljdCB0eXBlLWNoZWNraW5nICh0byBnZW5lcmF0ZSB3YXJuaW5ncyBpbnN0ZWFkIG9m
DQo+ICAqICAgbmFzdHkgcnVudGltZSBzdXJwcmlzZXMpLiBTZWUgdGhlICJ1bm5lY2Vzc2FyeSIg
cG9pbnRlciBjb21wYXJpc29uDQo+ICAqICAgaW4gX190eXBlY2hlY2soKS4NCj4gICogLSByZXRh
aW4gcmVzdWx0IGFzIGEgY29uc3RhbnQgZXhwcmVzc2lvbnMgd2hlbiBjYWxsZWQgd2l0aCBvbmx5
DQo+ICAqICAgY29uc3RhbnQgZXhwcmVzc2lvbnMgKHRvIGF2b2lkIHRyaXBwaW5nIFZMQSB3YXJu
aW5ncyBpbiBzdGFjaw0KPiAgKiAgIGFsbG9jYXRpb24gdXNhZ2UpLg0KPiAgKi8NCj4gDQo+IE5v
dGUgdGhhdCBhIG1vcmUgc3RyaWN0IHZlcnNpb24gdGhhdCBpbmNsdWRlcyBfX3R5cGVjaGVjayB3
b3VsZA0KPiB3YXJuIG9uIHRoZSB0eXBlIGRpZmZlcmVuY2UgYmV0d2VlbiB0b3RhbF9sZW4gYW5k
IGNmZ19tc3MuIEZpbmUNCj4gd2l0aCBjaGFuZ2luZyB0aGUgdHlwZSBvZiBjZmdfbXNzIGluIHRo
ZSBmb2xsb3ctb24gcGF0Y2ggdG8gYWRkcmVzcw0KPiB0aGF0Lg0KDQpUaGF0IHR5cGVjaGVjaygp
IGlzIGhvcnJpZC4NCkl0IG1heSB3ZWxsIGhhdmUgY2F1c2VkIG1vcmUgYnVncyBkdWUgdG8gaW5j
b3JyZWN0IGNhc3RzIHRoYXQNCml0IGFjdHVhbGx5IGRldGVjdGVkLg0KDQpJJ2Qgc3VnZ2VzdCB0
aGUgdmVyc2lvbiB0aGF0IGp1c3QgYXZvaWRzIG11bHRpcGxlIGV2YWx1YXRpb25zLg0KT3IganVz
dCBlcnJvciBzaWduZWQgdiB1bnNpZ25lZCBjb21wYXJpc29ucy4NClNlZSAgaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL2I0Y2U5ZGFkNzQ4ZTQ4OWY5MzE0YTJkYzk1NjE1MDMzQEFjdU1TLmFj
dWxhYi5jb20vDQpmb3IgYW4gZXhhbXBsZSBwYXRjaCBzZXQuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

