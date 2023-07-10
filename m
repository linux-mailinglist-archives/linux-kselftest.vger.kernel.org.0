Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0174D969
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGJPCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJPB7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 11:01:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EAACE
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 08:01:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-219-8n0LayikNHKp3BAPFXFbEw-1; Mon, 10 Jul 2023 16:01:53 +0100
X-MC-Unique: 8n0LayikNHKp3BAPFXFbEw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 10 Jul
 2023 16:01:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 10 Jul 2023 16:01:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Gow' <davidgow@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Noah Goldstein" <goldstein.w.n@gmail.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: checksum: Fix unaligned checksums on < i686
Thread-Topic: [PATCH] x86: checksum: Fix unaligned checksums on < i686
Thread-Index: AQHZrlJMciEqxmtZcEq0yT8S7Plt1a+zHllA
Date:   Mon, 10 Jul 2023 15:01:52 +0000
Message-ID: <519844640ae6483c8059a6440c620e01@AcuMS.aculab.com>
References: <20230704083206.693155-2-davidgow@google.com>
In-Reply-To: <20230704083206.693155-2-davidgow@google.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogRGF2aWQgR293DQo+IFNlbnQ6IDA0IEp1bHkgMjAyMyAwOTozMg0KPiANCj4gVGhlIGNo
ZWNrc3VtXzMyIGNvZGUgd2FzIG9yaWdpbmFsbHkgd3JpdHRlbiB0byBvbmx5IGhhbmRsZSAyLWJ5
dGUNCj4gYWxpZ25lZCBidWZmZXJzLCBidXQgd2FzIGxhdGVyIGV4dGVuZGVkIHRvIHN1cHBvcnQg
YXJiaXRyYXJ5IGFsaWdubWVudC4NCj4gSG93ZXZlciwgdGhlIG5vbi1QUHJvIHZhcmlhbnQgZG9l
c24ndCBhcHBseSB0aGUgY2FycnkgYmVmb3JlIGp1bXBpbmcgdG8NCj4gdGhlIDItIG9yIDQtYnl0
ZSBhbGlnbmVkIHZlcnNpb25zLCB3aGljaCBjbGVhciBDRi4NCi4uLi4NCj4gSSBhbHNvIHRlc3Rl
ZCBpdCBvbiBhIHJlYWwgNDg2RFgyLCB3aXRoIHRoZSBzYW1lIHJlc3VsdHMuDQoNCldoaWNoIGNw
dSBkb2VzIGFueW9uZSByZWFsbHkgY2FyZSBhYm91dD8NCg0KVGhlIHVucm9sbGVkICdhZGNsJyBs
b29wIGlzIGhvcnJpZCBvbiBpbnRlbCBjcHUgYmV0d2Vlbg0KKGFib3V0KSAnY29yZScgYW5kICdo
YXN3ZWxsJyBiZWNhdXNlIGVhY2ggdS1vcCBjYW4gb25seQ0KaGF2ZSB0d28gaW5wdXRzIGFuZCBh
ZGMgbmVlZHMgMyAtIHNvIGlzIDIgdS1vcHMuDQpGaXJzdCBmaXhlZCBieSBzdW1taW5nIHRvIGFs
dGVybmF0ZSByZWdpc3RlcnMuDQoNCk9uIGFueXRoaW5nIG1vZGVybiAod2VsbCBJJ3ZlIG5vdCBj
aGVja2VkIHNvbWUgQXRvbSBiYXNlZA0Kc2VydmVycykgbWlzYWxpZ25lZCBhY2Nlc3NlcyBhcmUg
cHJldHR5IG5lYXIgemVybyBjb3N0Lg0KU28gaXQgcmVhbGx5IGlzbid0IHdvcnRoIHRoZSB0ZXN0
cyB0aGF0IGFsaWduIGRhdGEuDQoNCihJIHN1c3BlY3QgaXQgYWxsIGdvdCBiZXR0ZXIgYSBsb25n
IHRpbWUgYWdvIGV4Y2VwdA0KZm9yIHRyYW5zZmVycyB0aGF0IGNyb3NzIGNhY2hlLWxpbmUgYm91
bmRhcmllcywgd2l0aA0KYWRjIHRha2luZyB0d28gY3ljbGVzIGV2ZW4gdGhhdCBtaWdodCBiZSBm
cmVlLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

