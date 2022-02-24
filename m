Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350A4C2208
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 04:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiBXDBY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 22:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiBXDBX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 22:01:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C67123BF30
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 19:00:53 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-44-yyNQcIKYMxqH48R7GhAS7Q-1; Thu, 24 Feb 2022 03:00:50 +0000
X-MC-Unique: yyNQcIKYMxqH48R7GhAS7Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 24 Feb 2022 03:00:49 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 24 Feb 2022 03:00:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <linus@torvalds.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: RE: How should rlimits, suid exec, and capabilities interact?
Thread-Topic: How should rlimits, suid exec, and capabilities interact?
Thread-Index: AQHYKR/SYXKB0CHhEUmLHiXZZydx7ayh8HMA
Date:   Thu, 24 Feb 2022 03:00:49 +0000
Message-ID: <a56fcc390a374b4da628ea55eb5dd6cc@AcuMS.aculab.com>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz>
 <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
 <878ru1qcos.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
In-Reply-To: <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgRmVicnVhcnkgMjAyMiAwMTo0Mg0KPiAN
Cj4gT24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgNToyNCBQTSBFcmljIFcuIEJpZWRlcm1hbiA8ZWJp
ZWRlcm1AeG1pc3Npb24uY29tPiB3cm90ZToNCj4gPg0KPiA+IFF1ZXN0aW9uOiBSdW5uaW5nIGEg
c3VpZCBwcm9ncmFtIHRvZGF5IGNoYXJnZXMgdGhlIGFjdGl2aXR5IG9mIHRoYXQNCj4gPiBwcm9n
cmFtIHRvIHRoZSB1c2VyIHdobyByYW4gdGhhdCBwcm9ncmFtLCBub3QgdG8gdGhlIHVzZXIgdGhl
IHByb2dyYW0NCj4gPiBydW5zIGFzLiAgRG9lcyBhbnlvbmUgc2VlIGEgcHJvYmxlbSB3aXRoIGNo
YXJnaW5nIHRoZSB1c2VyIHRoZSBwcm9ncmFtDQo+ID4gcnVucyBhcz8NCj4gDQo+IFNvIEkgdGhp
bmsgdGhhdCB0aGVyZSdzIGFjdHVhbGx5IHR3byBpbmRlcGVuZGVudCBpc3N1ZXMgd2l0aCBsaW1p
dHMNCj4gd2hlbiB5b3UgaGF2ZSBzaXR1YXRpb25zIGxpa2UgdGhpcyB3aGVyZSB0aGUgYWN0dWFs
IHVzZXIgbWlnaHQgYmUNCj4gYW1iaWd1b3VzLg0KPiANCj4gIC0gdGhlICJ3aG8gdG8gY2hhcmdl
IiBxdWVzdGlvbg0KPiANCj4gIC0gdGhlICJob3cgZG8gd2UgKmNoZWNrKiB0aGUgbGltaXQiIHF1
ZXN0aW9uDQo+IA0KPiBhbmQgaG9uZXN0bHksIEkgdGhpbmsgdGhhdCB3aGVuIGl0IGNvbWVzIHRv
IHN1aWQgYmluYXJpZXMsIHRoZSBmaXJzdA0KPiBxdWVzdGlvbiBpcyBmdW5kYW1lbnRhbGx5IGFt
YmlndW91cywgYmVjYXVzZSBpdCBhbG1vc3QgY2VydGFpbmx5DQo+IGRlcGVuZHMgb24gdGhlIHVz
ZXIuDQoNCkRvZXNuJ3QgdGhlIHJsaW1pdCBjaGVjayBoYXBwZW4gZHVyaW5nIHRoZSBmb3JrLg0K
QXQgd2hpY2ggdGltZSB5b3UgZG9uJ3Qga25vdyB0aGF0IGEgc3VpZCBleGVjIG1pZ2h0IGZvbGxv
dz8NCg0KVGhlIHByb2JsZW0gd2l0aCBjaGFuZ2luZyB0aGUgdWlkIGlzIHRoYXQgd2hlbiB0aGUg
cHJvY2VzcyBleGl0cw0KeW91IG5lZWQgdG8gInVuY2hhcmdlIiB0aGUgY29ycmVjdCB1aWQuDQpT
byBlaXRoZXIgeW91IG5lZWQgdG8gcmVtZW1iZXIgdGhlIG9yaWdpbmFsIHVpZCBvciBzZXR1aWQN
CmhhcyB0byB0cmFuc2ZlciB0aGUgY2hhcmdlICh3aGljaGV2ZXIgdWlkIGlzIHVzZWQpLg0KSWYg
eW91IHRyYW5zZmVyIHRoZSBjaGFyZ2UgdGhlbiB0aGUgc2V0dWlkIHN5c3RlbSBjYWxsIGNhbid0
IGZhaWwuDQpCdXQgYSBsYXRlciBleGVjIGNhbiBmYWlsLg0KDQpBbnkgY2hlY2sgd2lsbCBhbHdh
eXMgYmUgZG9uZSBhZ2FpbnN0IHRoZSBwcm9jZXNzJ3Mgb3duIHJsaW1pdCB2YWx1ZS4NClNldCB0
aGF0IHRvIHplcm8gYW5kIGZvcmsgc2hvdWxkIGZhaWwgcmVnYXJkbGVzcyBvZiB3aGljaCB1aWQn
cw0KcHJvY2VzcyBjb3VudCBpcyBjaGVja2VkLg0KDQpOb3cgYSBub3JtYWwgc3VpZCBwcm9ncmFt
IG9ubHkgY2hhbmdlcyB0aGUgZWZmZWN0aXZlIHVpZC4NClNvIGtlZXBpbmcgdGhlIHByb2Nlc3Mg
Y2hhcmdlZCBhZ2FpbnN0IHRoZSByZWFsIHVpZCBtYWtlcyBzZW5zZS4NCg0KSWYgYSBwcm9jZXNz
IGNoYW5nZXMgaXRzIHJlYWwgdWlkIHlvdSBjb3VsZCBjaGFuZ2UgdGhlIGNoYXJnZWQgdWlkDQpi
dXQgeW91IGNhbid0IGVycm9yIGlmIG92ZXIgdGhlIHJsaW1pdCB2YWx1ZS4NCk9UT0ggZHVyaW5n
IGEgbGF0ZXIgZXhlYyB5b3UgY2FuIHRlc3QgdGhpbmdzIGFuZCBleGVjIGNhbiBmYWlsLg0KDQpB
dCBsZWFzdCBvbmUgdW5peCBJJ3ZlIHVzZWQgaGFzIHRocmVlIHVpZHMgZm9yIGVhY2ggcHJvY2Vz
cy4NClRoZSAncmVhbCB1aWQnLCAnZWZmZWN0aXZlIHVpZCcgYW5kICdzYXZlZCBieSBleGVjIHVp
ZCcuDQpJIHN1c3BlY3QgdGhlIHByb2Nlc3MgaXMgYWx3YXlzICJjaGFyZ2VkIiBhZ2FpbnN0IHRo
ZSBsYXR0ZXIuDQpJIHRoaW5rIHRoYXQgZXhlYyBjb21wYXJlcyB0aGUgJ3JlYWwnIGFuZCAnc2F2
ZWQgYnkgZXhlYycgdWlkcw0KYW5kLCBpZiBkaWZmZXJlbnQsIG1vdmVzIHRoZSBjaGFyZ2UgdG8g
dGhlIHJlYWwgdWlkICh3aGljaCB3aWxsDQpjaGVjayBybGltaXQpIHRoZW4gc2V0cyB0aGUgJ3Nh
dmVkIGJ5IGV4ZWMgdWlkJyB0byB0aGUgcmVhbCB1aWQuDQoNClNvIGFuIGV4ZWMgYWZ0ZXIgYSBz
ZXR1aWQoKSBjYW4gYmUgYWxsb3dlZCB0byBmYWlsIGlmIHRoZSByZWFsIHVzZXINCmhhcyB0b28g
bWFueSBwcm9jZXNzZXMuDQpCdXQgaW4gYWxsIG90aGVyIGNhc2VzIGV4ZWMganVzdCB3b3JrcyBy
ZWdhcmRsZXNzIG9mIHRoZSBwcm9jZXNzDQpjb3VudCBmb3IgYW55IHVzZXIuDQoNCj4gDQo+IFdo
aWNoIHRvIG1lIGltcGxpZXMgdGhhdCB0aGVyZSBwcm9iYWJseSBpc24ndCBhbiBhbnN3ZXIgdGhh
dCBpcyBhbHdheXMNCj4gcmlnaHQsIGFuZCB0aGF0IHdoYXQgeW91IHNob3VsZCBsb29rIGF0IGlz
IHRoYXQgc2Vjb25kIG9wdGlvbi4NCj4gDQo+IFNvIEkgd291bGQgYWN0dWFsbHkgc3VnZ2VzdCB0
aGF0IHRoZSAiZXhlY3V0ZSBhIHN1aWQgYmluYXJ5IiBzaG91bGQNCj4gY2hhcmdlIHRoZSByZWFs
IHVzZXIsIGJ1dCAqYmVjYXVzZSogaXQgaXMgc3VpZCwgaXQgc2hvdWxkIHRoZW4gbm90DQo+IGNo
ZWNrIHRoZSBsaW1pdCAob3IsIHBlcmhhcHMsIHNob3VsZCBjaGVjayB0aGUgaGFyZCBsaW1pdD8p
Lg0KPiANCj4gWW91IGhhdmUgdG8gY2hhcmdlIHNvbWVib2R5LCBidXQgYXQgdGhhdCBwb2ludCBp
dCdzIGEgYml0IGFtYmlndW91cw0KPiB3aGV0aGVyIGl0IHNob3VsZCBiZSBhbGxvd2VkLg0KPiAN
Cj4gRXhhY3RseSBzbyB0aGF0IGlmIHlvdSdyZSBvdmVyIGEgcHJvY2VzcyBsaW1pdCAob3Igc29t
ZXRoaW5nIHNpbWlsYXIgLQ0KPiB0aGluayAidG9vIG1hbnkgZmlsZXMgb3BlbiIgb3Igd2hhdGV2
ZXIgYmVjYXVzZSB5b3Ugc2NyZXdlZCB1cCBhbmQNCj4gb3BlbmVkIGV2ZXJ5dGhpbmcpIHlvdSBj
b3VsZCBzdGlsbCBsb2cgaW4gYXMgeW91cnNlbGYgKHNzaC9sb2dpbg0KPiBjaGFyZ2VzIHNvbWUg
YWRtaW4gdGhpbmcsIHdoaWNoIHByb2JhYmx5IGhhcyBoaWdoIGxpbWl0cyBvciBpcw0KPiB1bmxp
bWl0ZWQpLCBhbmQgaG9wZWZ1bGx5IGdldCBzaGVsbCBhY2Nlc3MsIGFuZCB0aGVuIGJlIGFibGUg
dG8gImV4ZWMNCj4gc3VkbyIgdG8gYWN0dWFsbHkgZ2V0IGFkbWluIGFjY2VzcyB0aGF0IHNob3Vs
ZCBiZSBkaXNhYmxlZCBmcm9tIHRoZQ0KPiBuZXR3b3JrLg0KDQpZb3UgdXN1YWxseSBoYXZlIHRv
IHVzZSAncnNoIG1hY2hpbmUgc2ggLWknIHRvIGF2b2lkIHRoZSBzaGVsbA0KcnVubmluZyBhbGwg
aXRzIHN0YXJ0dXAgc2NyaXB0cy4NCkJ1dCBJIGRvdWJ0IHRoYXQgd2lsbCBnZXQgeW91IHBhc3Qg
YSBmb3JrIGJvbWIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

