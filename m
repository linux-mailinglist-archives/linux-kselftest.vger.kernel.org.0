Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50347844AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbjHVOsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjHVOsP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 10:48:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F641BE
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 07:48:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-67-D5qlW6B2MLuti1GsDH0uYA-1; Tue, 22 Aug 2023 15:48:10 +0100
X-MC-Unique: D5qlW6B2MLuti1GsDH0uYA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 22 Aug
 2023 15:48:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 22 Aug 2023 15:48:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: RE: [PATCH 1/2] selftests: Provide local define of min() and max()
Thread-Topic: [PATCH 1/2] selftests: Provide local define of min() and max()
Thread-Index: AQHZ03nFpJJs9cS/jEaiicM+CY14+6/0t4aQgAGcP4CAABL1kA==
Date:   Tue, 22 Aug 2023 14:48:08 +0000
Message-ID: <d33fbb24119c4d09864e79ea9dfbb881@AcuMS.aculab.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
 <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
 <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
 <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
In-Reply-To: <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
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

Li4uDQo+ID4gVGhhdCB0eXBlY2hlY2soKSBpcyBob3JyaWQuDQo+ID4gSXQgbWF5IHdlbGwgaGF2
ZSBjYXVzZWQgbW9yZSBidWdzIGR1ZSB0byBpbmNvcnJlY3QgY2FzdHMgdGhhdA0KPiA+IGl0IGFj
dHVhbGx5IGRldGVjdGVkLg0KPiA+DQo+ID4gSSdkIHN1Z2dlc3QgdGhlIHZlcnNpb24gdGhhdCBq
dXN0IGF2b2lkcyBtdWx0aXBsZSBldmFsdWF0aW9ucy4NCj4gPiBPciBqdXN0IGVycm9yIHNpZ25l
ZCB2IHVuc2lnbmVkIGNvbXBhcmlzb25zLg0KPiA+IFNlZSAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsL2I0Y2U5ZGFkNzQ4ZTQ4OWY5MzE0YTJkYzk1NjE1MDMzQEFjdU1TLmFjdWxhYi5jb20v
DQo+ID4gZm9yIGFuIGV4YW1wbGUgcGF0Y2ggc2V0Lg0KPiANCj4gSW50ZXJlc3RpbmcsIHRoYW5r
cy4gVGhhdCBpcyBhbHNvIHNpbXBsZXIuDQo+IA0KPiBBbHNvLCB0aGUgZXhpc3RpbmcgcGF0Y2gg
aXMgbm8gd29yc2UgdGhhbiB0aGUgb3BlbiBjb2RlZCBjb2RlIHRvZGF5LA0KPiBzbyBldmVuIHdp
dGhvdXQgY29kZSB0byBhdm9pZCBtdWx0aXBsZSBldmFsdWF0aW9ucywgSSBndWVzcyBpdCdzIG9r
YXkNCj4gdG8gbWVyZ2UuDQo+IA0KPiBUaGUgY29jY2luZWxsZSB3YXJuaW5ncyBhcmUgYXJndWFi
bHkgZmFsc2UgcG9zaXRpdmVzLCB1c2luZyBjaGVja3MgZm9yDQo+IGtlcm5lbCBjb2RlLCBidXQg
YmVpbmcgcnVuIGFnYWluc3QgdXNlcnNwYWNlIGNvZGUgdGhhdCBoYXMgbm8gYWNjZXNzDQo+IHRv
IHRob3NlIGhlbHBlcnMuIEJ1dCBmaW5lIHRvIHNpbGVuY2UgdGhlbS4NCg0KWW91IGNhbid0IHVz
ZSBpc19jb25zdGV4cHIoKSB1bmxlc3MgJ3NpemVvZiAqKHZvaWQgKiknIGlzIHZhbGlkLg0KQW5k
IGJ1aWx0aW5fY29uc3RhbnQoKSBpc24ndCBnb29kIGVub3VnaCBmb3IgYnVpbHRpbl9jaG9vc2Vf
ZXhwcigpLg0KDQpUaGF0IG1pZ2h0IGJlIG9rIGZvciBzZWxmdGVzdHMgYW5kIHRvb2xzLCBidXQg
bm90IGZvciBnZW5lcmFsdXNlcnNwYWNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

