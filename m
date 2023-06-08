Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C147282D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbjFHOgA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 10:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbjFHOf6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 10:35:58 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DE2715
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 07:35:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-NXZg-_eNOaO8RckaE_lZ0g-1; Thu, 08 Jun 2023 15:35:52 +0100
X-MC-Unique: NXZg-_eNOaO8RckaE_lZ0g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 8 Jun
 2023 15:35:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 8 Jun 2023 15:35:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhangjin Wu' <falcon@tinylab.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Subject: RE: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and
 __sysret() helpers
Thread-Topic: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and
 __sysret() helpers
Thread-Index: AQHZmE5QSUsfyUxi2UiZnouHjWtcta+A+37Q
Date:   Thu, 8 Jun 2023 14:35:49 +0000
Message-ID: <94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com>
References: <cover.1686036862.git.falcon@tinylab.org>
 <a42fb9e1bbe0daf7d8a48ea8f44135ef851030d7.1686036862.git.falcon@tinylab.org>
In-Reply-To: <a42fb9e1bbe0daf7d8a48ea8f44135ef851030d7.1686036862.git.falcon@tinylab.org>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogWmhhbmdqaW4gV3UNCj4gU2VudDogMDYgSnVuZSAyMDIzIDA5OjEwDQo+IA0KPiBtb3N0
IG9mIHRoZSBsaWJyYXJ5IHJvdXRpbmVzIHNoYXJlIHRoZSBzYW1lIGNvZGUgbW9kZWwsIGxldCdz
IGFkZCB0d28NCj4gaGVscGVycyB0byBzaW1wbGlmeSB0aGUgY29kaW5nIGFuZCBzaHJpbmsgdGhl
IGNvZGUgbGluZXMgdG9vLg0KPiANCi4uLg0KPiArLyogU3lzY2FsbCByZXR1cm4gaGVscGVyLCBz
ZXQgZXJybm8gYXMgLXJldCB3aGVuIHJldCA8IDAgKi8NCj4gK3N0YXRpYyBpbmxpbmUgX19hdHRy
aWJ1dGVfXygoYWx3YXlzX2lubGluZSkpIGxvbmcgX19zeXNyZXQobG9uZyByZXQpDQo+ICt7DQo+
ICsJaWYgKHJldCA8IDApIHsNCj4gKwkJU0VUX0VSUk5PKC1yZXQpOw0KPiArCQlyZXQgPSAtMTsN
Cj4gKwl9DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCg0KSWYgdGhhdCByaWdodD8NCkkgdGhvdWdo
dCB0aGF0IHRoYXQgb25seSB0aGUgZmlyc3QgZmV3ICgxMDI0PykgbmVnYXRpdmUgdmFsdWVzDQpn
b3QgdXNlZCBhcyBlcnJubyB2YWx1ZXMuDQoNCkRvIGFsbCBMaW51eCBhcmNoaXRlY3R1cmVzIGV2
ZW4gdXNlIG5lZ2F0aXZlcyBmb3IgZXJyb3I/DQpJIHRob3VnaHQgYXQgbGVhc3Qgc29tZSB1c2Vk
IHRoZSBjYXJyeSBmbGFnLg0KKEl0IGlzIHRoZSBoaXN0b3JpYyBtZXRob2Qgb2YgaW5kaWNhdGlu
ZyBhIHN5c3RlbSBjYWxsIGZhaWx1cmUuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

