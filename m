Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D11F771D91
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjHGJxi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHGJxg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 05:53:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC61711
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 02:53:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-258-aI0RKJy1M2uSLFOio4P2fg-1; Mon, 07 Aug 2023 10:53:17 +0100
X-MC-Unique: aI0RKJy1M2uSLFOio4P2fg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Aug
 2023 10:53:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Aug 2023 10:53:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Zhangjin Wu' <falcon@tinylab.org>, "w@1wt.eu" <w@1wt.eu>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "thomas@t-8ch.de" <thomas@t-8ch.de>
Subject: RE: [PATCH v3] tools/nolibc: fix up size inflate regression
Thread-Topic: [PATCH v3] tools/nolibc: fix up size inflate regression
Thread-Index: AQHZyPQZCzWEgy7xdkqtRS3MdkRe3q/efQWQgAAY3cA=
Date:   Mon, 7 Aug 2023 09:53:07 +0000
Message-ID: <2e6897775c5147a8a31fc6678eb01a8c@AcuMS.aculab.com>
References: <8eaab5da2dcbba42e3f3efc2ae686a22c95f84f0.1691386601.git.falcon@tinylab.org>
 <f51e54bcf470451ea36f24640f000e61@AcuMS.aculab.com>
In-Reply-To: <f51e54bcf470451ea36f24640f000e61@AcuMS.aculab.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDA3IEF1Z3VzdCAyMDIzIDA5OjQwDQouLi4uDQo+
IHdpdGggKHJldHlwZWQgc28gaXQgbWF5IGJlIHdyb25nKToNCj4gI2RlZmluZSBpc19jb25zdGV4
cHIoeCkgc2l6ZW9mKCooMCA/ICh2b2lkICopKChsb25nKSh4KSAqIDApIDogKGludCAqKTApKSA9
PSAxKQ0KDQpCYWgsIEkga25vdyB3aHkgdGhhdCB3b3JrcyBhbmQgSSBzdGlsbCBnb3QgaXMgYmFj
a3dhcmRzIDotKA0KQmFzaWNhbGx5IHRoZSBjb21waWxlciBuZWVkcyB0byBmaW5kIGEgdHlwZSB0
aGF0IGlzICdjb21wYXRpYmxlJw0Kd2l0aCBib3RoIHRoZSBwb3NzaWJsZSByZXN1bHRzLg0KU2lu
Y2UgJyh2b2lkICopMCcgaXMgYSB2YWxpZCAnaW50IConIHZhbHVlIHRoYXQgZ2l2ZXMgJ2ludCAq
Jy4NCkJ1dCAnKHZvaWQgKikoYW55dGhpbmdfZWxzZSknIHJlcXVpcmVzIHRoZSAnaW50IConIGJl
IGNvbnZlcnRlZA0KdG8gJ3ZvaWQgKicuDQoNCkFsc28gdGhlIGZvbGxvd2luZyBzZWVtcyB0byBj
b21waWxlIHRvIHNhbmUgY29kZQ0KZm9yIGFsbCB0eXBlcyBvbiAzMmJpdCBhbmQgNjRiaXQgeDg2
Lg0KDQppbnQgZXJybm87DQoNCiNkZWZpbmUgTUFYRVJSTk8gMHg0MDAwDQojZGVmaW5lIHR5cGUg
aW50ICoNCg0KdHlwZSBzeXNyZXQodHlwZSBhcmcpDQp7DQogICAgaWYgKCh1bnNpZ25lZCBsb25n
KWFyZyA8IDB1bCAtIE1BWEVSUk5PKQ0KICAgICAgICByZXR1cm4gYXJnOw0KDQogICAgZXJybm8g
PSAtKGxvbmcpYXJnOw0KICAgIHJldHVybiAoX190eXBlb2YoYXJnKSktMTsgICAgICAgIA0KfQ0K
DQpZb3UgZG8gZ2V0IGEgY29tcGFyaXNvbiBidXQgbm8gc2lnbiBleHRlbnNpb25zLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

