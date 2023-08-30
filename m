Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339DF78DAAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjH3Sgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjH3QVQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 12:21:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29661A4
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 09:21:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-76-NLkRhACHMZubfs6D4dRRWg-1; Wed, 30 Aug 2023 17:21:10 +0100
X-MC-Unique: NLkRhACHMZubfs6D4dRRWg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 30 Aug
 2023 17:21:02 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 30 Aug 2023 17:21:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ammar Faizi' <ammarfaizi2@gnuweeb.org>,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>
CC:     Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas@t-8ch.de>,
        Yuan Tan <tanyuan@tinylab.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: RE: [RFC] tools/nolibc: replace duplicated -ENOSYS return with single
 -ENOSYS return
Thread-Topic: [RFC] tools/nolibc: replace duplicated -ENOSYS return with
 single -ENOSYS return
Thread-Index: AdnbXfVru8RTG9gTQ+SsAG5ax7hYow==
Date:   Wed, 30 Aug 2023 16:21:02 +0000
Message-ID: <2d52dbd55e6240d5a91ebdce67fe0b7b@AcuMS.aculab.com>
References: <20230827083225.7534-1-falcon@tinylab.org>
 <4bbdea1710464fa2943663a25bf370c9@AcuMS.aculab.com>
 <6f93ea82-f157-e921-2028-5b4fae4ad341@gnuweeb.org>
In-Reply-To: <6f93ea82-f157-e921-2028-5b4fae4ad341@gnuweeb.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogQW1tYXIgRmFpemkNCj4gU2VudDogMzAgQXVndXN0IDIwMjMgMTU6NDENCj4gDQo+IE9u
IDgvMjgvMjMgNDo1MSBBTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEkganVzdCBmb3VuZCBh
KG5vdGhlcikgY2xhbmcgYnVnOg0KPiA+IAlpbnQgZih2b2lkKSB7IHJldHVybiAiYSJbMl07IH0N
Cj4gPiBjb21waWxlcyB0byBqdXN0IGEgJ3JldHVybicuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRo
YXQncyBhIGJ1Zy4gSXQncyB1bmRlZmluZWQgYmVoYXZpb3IgZHVlIHRvIGFuDQo+IG91dC1vZi1i
b3VuZCByZWFkLiBXaGF0IGRvIHlvdSBleHBlY3QgaXQgdG8gcmV0dXJuPw0KDQpJIHdhcyBhY3R1
YWxseSBleHBlY3RpbmcgYSB3YXJuaW5nL2Vycm9yIGlmIGl0IGRpZG4ndCBqdXN0IHJlYWQNCnRo
ZSBieXRlIGFmdGVyIHRoZSBlbmQgb2YgdGhlIHN0cmluZy4NCg0KSnVzdCBzaWxlbnRseSBkb2lu
ZyBub3RoaW5nIGRpZG4ndCBzZWVtIHJpZ2h0IGZvciBhIG1vZGVybiBjb21waWxlci4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

