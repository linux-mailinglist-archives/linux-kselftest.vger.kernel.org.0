Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46D72AD8A
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFJQ7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFJQ7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:59:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138BF2D41
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:59:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-98-8BQbVs2MNh2fTOBXaJ3mkg-1; Sat, 10 Jun 2023 17:58:58 +0100
X-MC-Unique: 8BQbVs2MNh2fTOBXaJ3mkg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Jun
 2023 17:58:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Jun 2023 17:58:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: RE: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Thread-Topic: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Thread-Index: AQHZmQJ1YTdtMnXhOkqSBnIhvL9uWq+EPW+ggAAJOcA=
Date:   Sat, 10 Jun 2023 16:58:54 +0000
Message-ID: <6dcd7c69f95f4fed8cc3d0add1f7d6e9@AcuMS.aculab.com>
References: <ZIAB7bFYegCuXT9g@1wt.eu>
 <20230607053920.667272-1-falcon@tinylab.org>
 <0295105fe0744200bf2ef99e5bf7bc09@AcuMS.aculab.com>
In-Reply-To: <0295105fe0744200bf2ef99e5bf7bc09@AcuMS.aculab.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDEwIEp1bmUgMjAyMyAxNzozNA0KPiANCj4gRnJv
bTogWmhhbmdqaW4gV3UNCj4gPiBTZW50OiAwNyBKdW5lIDIwMjMgMDY6MzkNCj4gLi4uDQo+ID4g
QXMgYSBzdW1tYXJ5LCB3aWxsIHVzZSAnc3lzcmV0KCknIGFuZCBzb21ldGhpbmcgbGlrZToNCj4g
Pg0KPiA+ICAgIHN0YXRpYyBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKQ0KPiA+ICAgIGludCBjaGRp
cihjb25zdCBjaGFyICpwYXRoKQ0KPiA+ICAgIHsNCj4gPiAgICAJcmV0dXJuIHN5c3JldChjaGRp
cihwYXRoKSk7DQo+ID4gICAgfQ0KPiA+DQo+ID4gdG8gcmVuZXcgdGhlIHN5c2NhbGwgaGVscGVy
IHBhdGNoc2V0LCBUaGFua3MgeW91IHZlcnkgbXVjaC4NCj4gDQo+IFdoaWxlIEknbSBhbGwgZm9y
IHVzaW5nICdjcHAtbWFnaWMnIHRvIGFic3RyYWN0IGFuZCAoaG9wZWZ1bGx5KQ0KPiBzaW1wbGlm
eSB0aGluZ3MuIFRva2VuLXBhc3RpbmcgdGhlIHN5c18gaGVyZSBkb2Vzbid0IHNlZW0gdG8gZ2Fp
bg0KPiBhbnl0aGluZy4NCj4gQW55b25lIGdyZXBwaW5nIHRoZSBjb2RlIGZvciAnc3lzX2NoZGly
JyBpcyBhbHNvIGdvaW5nIHRvDQo+IHdvbmRlciB3aGVyZSBpdCBpcyB1c2VkLg0KDQpJIHRoaW5r
IEkndmUgc3BvdHRlZCBhIGxhdGVyIHZlcnNpb24gb2YgdGhlIHBhdGNoDQp0aGF0IGRvZXNuJ3Qg
cGFzdGUgdGhlIHN5c18NCg0KPiBUaGVyZSBtaWdodCBiZSBzY29wZSBmb3Igc29tZXRoaW5nIGxp
a2U6DQo+ICNkZWZpbmUgc3lzY2FsbF93cmFwcGVyKGZ1bmMsIHR5cGUpIFwNCj4gCXN0YXRpYyBf
X2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSBcDQo+IAlpbnQgZnVuYyh0eXBlICphcmcpIFwNCj4gCXsg
XA0KPiAJCXJldHVybiBzeXNyZXQoc3lzXyNmdW5jKGFyZykpOyBcDQo+IAl9DQo+IGFuZCB0aGVu
Og0KPiBzeXNjYWxsX3dyYXBwZXIoY2hkaXIsIGNvbnN0IGNoYXIgKikNCj4gd291bGQgZXhwYW5k
IHRvIHRoZSBjb2RlIGFib3ZlLg0KPiANCj4gSSB0aGluayB5b3UnZCBuZWVkIHNlcGFyYXRlIGRl
ZmluZXMgZm9yIGVhY2ggbnVtYmVyIG9mIGFyZ3VtZW50cy4NCg0KSXQgaXMgYWxzbyB3b3J0aCBw
b2ludGluZyBvdXQgdGhhdCBvbmNlIHRoZSAnc3RhdGljIHVudXNlZCcNCmZ1bmN0aW9ucyBoYXZl
IGJlZW4gZGVmaW5lZCwgYWxsIHRoZSAjZGVmaW5lICdnb29wJyB1c2VkIHRvDQpkZWZpbmUgdGhl
bSBjYW4gYmUgc3VtbWFyaWx5ICN1bmRlZidlZC4NClRoYXQgKG1vc3RseSkgc29sdmVzIHRoZSBu
YW1lc3BhY2UgcHJvYmxlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

