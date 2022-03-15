Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1F4D95C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 08:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiCOH55 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245208AbiCOH5o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 03:57:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F9774BBB6
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 00:56:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-216-xYBwVrWXPkuS3LcJVzhFpQ-1; Tue, 15 Mar 2022 07:56:28 +0000
X-MC-Unique: xYBwVrWXPkuS3LcJVzhFpQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 15 Mar 2022 07:56:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 15 Mar 2022 07:56:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'T.J. Mercier'" <tjmercier@google.com>,
        Todd Kjos <tkjos@google.com>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        "Hridya Valsaraju" <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        "Brian Starkey" <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        "Tejun Heo" <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Kenny.Ho@amd.com" <Kenny.Ho@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [RFC v3 7/8] binder: use __kernel_pid_t and __kernel_uid_t for
 userspace
Thread-Topic: [RFC v3 7/8] binder: use __kernel_pid_t and __kernel_uid_t for
 userspace
Thread-Index: AQHYN/2hnJZ5hPm3HkKIFJirFaEIKazAEl4g
Date:   Tue, 15 Mar 2022 07:56:26 +0000
Message-ID: <a365a5f6c7864a879b133b99d1f43fb2@AcuMS.aculab.com>
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-8-tjmercier@google.com>
 <CAHRSSEy5_h9LJB4q5_OJA7fSq=ROo68UaK+hdPz-Vj-wac1Qhg@mail.gmail.com>
 <CABdmKX1G0Rwmz7=BP1ER+TmtrnkGiE0nROsPTHKxnj=6bHhY3Q@mail.gmail.com>
In-Reply-To: <CABdmKX1G0Rwmz7=BP1ER+TmtrnkGiE0nROsPTHKxnj=6bHhY3Q@mail.gmail.com>
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

RnJvbTogVC5KLiBNZXJjaWVyDQo+IFNlbnQ6IDE0IE1hcmNoIDIwMjIgMjM6NDUNCj4gDQo+IE9u
IFRodSwgTWFyIDEwLCAyMDIyIGF0IDExOjMzIEFNIFRvZGQgS2pvcyA8dGtqb3NAZ29vZ2xlLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIE1hciA5LCAyMDIyIGF0IDg6NTIgQU0gVC5KLiBN
ZXJjaWVyIDx0am1lcmNpZXJAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gVGhlIGtl
cm5lbCBpbnRlcmZhY2Ugc2hvdWxkIHVzZSB0eXBlcyB0aGF0IHRoZSBrZXJuZWwgZGVmaW5lcyBp
bnN0ZWFkIG9mDQo+ID4gPiBwaWRfdCBhbmQgdWlkX3QsIHdob3NlIGRlZmluaXRvbiBpcyBvd25l
ZCBieSBsaWJjLiBUaGlzIGZpeGVzIHRoZSBoZWFkZXINCj4gPiA+IHNvIHRoYXQgaXQgY2FuIGJl
IGluY2x1ZGVkIHdpdGhvdXQgZmlyc3QgaW5jbHVkaW5nIHN5cy90eXBlcy5oLg0KPiA+ID4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFQuSi4gTWVyY2llciA8dGptZXJjaWVyQGdvb2dsZS5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvYW5kcm9pZC9iaW5kZXIuaCB8IDQg
KystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9hbmRyb2lk
L2JpbmRlci5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2FuZHJvaWQvYmluZGVyLmgNCj4gPiA+IGlu
ZGV4IDE2OWZkNTA2OWExYS4uYWEyODQ1NGRiY2EzIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVk
ZS91YXBpL2xpbnV4L2FuZHJvaWQvYmluZGVyLmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9s
aW51eC9hbmRyb2lkL2JpbmRlci5oDQo+ID4gPiBAQCAtMjg5LDggKzI4OSw4IEBAIHN0cnVjdCBi
aW5kZXJfdHJhbnNhY3Rpb25fZGF0YSB7DQo+ID4gPg0KPiA+ID4gICAgICAgICAvKiBHZW5lcmFs
IGluZm9ybWF0aW9uIGFib3V0IHRoZSB0cmFuc2FjdGlvbi4gKi8NCj4gPiA+ICAgICAgICAgX191
MzIgICAgICAgICAgIGZsYWdzOw0KPiA+ID4gLSAgICAgICBwaWRfdCAgICAgICAgICAgc2VuZGVy
X3BpZDsNCj4gPiA+IC0gICAgICAgdWlkX3QgICAgICAgICAgIHNlbmRlcl9ldWlkOw0KPiA+ID4g
KyAgICAgICBfX2tlcm5lbF9waWRfdCAgc2VuZGVyX3BpZDsNCj4gPiA+ICsgICAgICAgX19rZXJu
ZWxfdWlkX3QgIHNlbmRlcl9ldWlkOw0KPiA+DQo+ID4gQXJlIHdlIGd1YXJhbnRlZWQgdGhhdCB0
aGlzIGRvZXMgbm90IGFmZmVjdCB0aGUgVUFQSSBhdCBhbGw/IFVzZXJzcGFjZQ0KPiA+IGNvZGUg
dXNpbmcgdGhpcyBkZWZpbml0aW9uIHdpbGwgaGF2ZSB0byBydW4gd2l0aCBrZXJuZWxzIHVzaW5n
IHRoZSBvbGQNCj4gPiBkZWZpbml0aW9uIGFuZCB2aXNhLXZlcnNhLg0KPiANCj4gQSBzdGFuZGFy
ZHMgY29tcGxpYW50IHVzZXJzcGFjZSBzaG91bGQgYmUgZXhwZWN0aW5nIGEgc2lnbmVkIGludGVn
ZXINCj4gdHlwZSBoZXJlLiBTbyB0aGUgb25seSB3YXkgSSBjYW4gdGhpbmsgdXNlcnNwYWNlIHdv
dWxkIGJlIGFmZmVjdGVkIGlzDQo+IGlmOg0KPiAxKSBwaWRfdCBpcyBhIGxvbmcgQU5EDQo+IDIp
IHNpemVvZihsb25nKSA+IHNpemVvZihpbnQpIEFORA0KPiAzKSBDb25zdW1lcnMgb2YgdGhlIHBp
ZF90IGRlZmluaXRpb24gYWN0dWFsbHkgYXR0ZW1wdCB0byBtdXRhdGUgdGhlDQo+IHJlc3VsdCB0
byBtYWtlIHVzZSBvZiBleHRyYSBiaXRzIGluIHRoZSB2YXJpYWJsZSAod2hpY2ggYXJlIG5vdCB0
aGVyZSkNCg0KT3IgdGhlIHVzZXJzcGFjZSBoZWFkZXJzIGhhdmUgYSAxNmJpdCBwaWRfdC4NCg0K
SSBjYW4ndCBoZWxwIGZlZWxpbmcgdGhhdCB1YXBpIGhlYWRlcnMgc2hvdWxkIG9ubHkgdXNlIGV4
cGxpY2l0DQpmaXhlZCBzaXplZCB0eXBlcy4NClRoZXJlIGlzIG5vIHBvaW50IGluZGlyZWN0aW5n
IHRoZSB0eXBlIG5hbWVzIC0gdGhlIHNpemVzIHN0aWxsDQpjYW4ndCBiZSBjaGFuZ2VzLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

