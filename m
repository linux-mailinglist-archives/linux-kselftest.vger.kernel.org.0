Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EC363D67
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhDSIXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 04:23:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:59941 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhDSIXA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 04:23:00 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-173-Jw5v629MP6SNyxusFjbP0g-1; Mon, 19 Apr 2021 09:22:22 +0100
X-MC-Unique: Jw5v629MP6SNyxusFjbP0g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 09:22:21 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 19 Apr 2021 09:22:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'wangyanan (Y)'" <wangyanan55@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        kvm <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 03/10] KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for
 timing
Thread-Topic: [PATCH v6 03/10] KVM: selftests: Use flag CLOCK_MONOTONIC_RAW
 for timing
Thread-Index: AQHXNObaeVOoTXOm4UClXGWfioY7I6q7fhHA
Date:   Mon, 19 Apr 2021 08:22:21 +0000
Message-ID: <8f36c1973c8147858000dd2a28d046ce@AcuMS.aculab.com>
References: <20210330080856.14940-1-wangyanan55@huawei.com>
 <20210330080856.14940-4-wangyanan55@huawei.com>
 <1f892f30-1a72-1bcb-462f-b3d6f2bababb@redhat.com>
 <82def592-e36c-25c3-c8c5-84c9be83e926@huawei.com>
In-Reply-To: <82def592-e36c-25c3-c8c5-84c9be83e926@huawei.com>
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
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogd2FuZ3lhbmFuIChZKQ0KPiBTZW50OiAxOSBBcHJpbCAyMDIxIDA3OjQwDQo+IA0KPiBI
aSBQYW9sbywNCj4gDQo+IE9uIDIwMjEvNC8xNyAyMToyMywgUGFvbG8gQm9uemluaSB3cm90ZToN
Cj4gPiBPbiAzMC8wMy8yMSAxMDowOCwgWWFuYW4gV2FuZyB3cm90ZToNCj4gPj4gSW4gYWRkaXRp
b24gdG8gZnVuY3Rpb24gb2YgQ0xPQ0tfTU9OT1RPTklDLCBmbGFnIENMT0NLX01PTk9UT05JQ19S
QVcgY2FuDQo+ID4+IGFsc28gc2hpZWxkIHBvc3NpYWJsZSBpbXBhY3Qgb2YgTlRQLCB3aGljaCBj
YW4gcHJvdmlkZSBtb3JlIHJvYnVzdG5lc3MuDQo+ID4+DQo+ID4+IFN1Z2dlc3RlZC1ieTogVml0
YWx5IEt1em5ldHNvdjx2a3V6bmV0c0ByZWRoYXQuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBZ
YW5hbiBXYW5nPHdhbmd5YW5hbjU1QGh1YXdlaS5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBCZW4g
R2FyZG9uPGJnYXJkb25AZ29vZ2xlLmNvbT4NCj4gPj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBKb25l
czxkcmpvbmVzQHJlZGhhdC5jb20+DQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcyBv
bmUsIGlzIHRoZSBlZmZlY3QgdmlzaWJsZT8NCj4gPg0KPiBJbiBwcmFjdGljZSwgZGlmZmVyZW5j
ZSBiZXR3ZWVuIHJlc3VsdHMgZ290IHdpdGggQ0xPQ0tfTU9OT1RPTklDIGFuZA0KPiBDTE9DS19N
T05PVE9OSUNfUkFXDQo+IGFjdHVhbGx5IGlzIHRvbyBsaXR0bGUgdG8gYmUgdmlzaWJsZS4gQnV0
IGlmIGp1c3QgaW4gdGhlb3J5LA0KPiBDTE9DS19NT05PVE9OSUNfUkFXIGNhbiBlbnN1cmUgdGlt
ZSByZXN1bHRzDQo+IG9mIHRoZSBjb21wYXJlZCB0ZXN0cyBhcmUgYmFzZWQgb24gdGhlIHNhbWUg
bG9jYWwgb3NjaWxsYXRvciBmcmVxdWVuY3ksDQo+IHdoaWNoIGlzIG5vdCBzdWJqZWN0IHRvIHBv
c3NpYmxlDQo+IE5UUCBmcmVxdWVuY3kgYWRqdXN0bWVudC4gQ2hhbmdlIGluIHRoaXMgcGF0Y2gg
c2VlbXMgbGlrZSBhIGJpdCBvZg0KPiBvcHRpbWl6YXRpb24uDQoNClRoZSByZWFsIGFubm95YW5j
ZSBpcyB3aGVuIE5UUCBpcyByZWFsaWduaW5nIHRoZSBsb2NhbCBjbG9jay4NClRoaXMgdHlwaWNh
bGx5IGhhcHBlbnMgYWZ0ZXIgYm9vdCAtIGJ1dCBjYW4gdGFrZSBxdWl0ZSBhIGZldw0KbWludXRl
cyAoZG9uJ3QgdGhpbmsgaXQgY2FuIHF1aXRlIGdldCB0byBhbiBob3VyKS4NCihJIHRoaW5rIHNv
bWV0aGluZyBzaW1pbGFyIGlzIGNhdXNlZCBieSBsZWFwIHNlY29uZHMuKQ0KDQpEdXJpbmcgdGhp
cyBwZXJpb2QgQ0xPQ0tfTU9OT1RPTklDIGNhbiBydW4gYXQgYSBzaWduaWZpY2FudGx5DQpkaWZm
ZXJlbnQgcmF0ZSBmcm9tICdyZWFsIHRpbWUnLg0KVGhpcyBtYXkgbm90IG1hdHRlciBmb3IgdGlt
aW5nIHNlbGYgdGVzdHMsIGJ1dCBpcyBzaWduaWZpY2FudA0KZm9yIFJUUCBhdWRpby4NCg0KVGhl
IHByb2JsZW0gdGhlcmUgaXMgdGhhdCB5b3Ugd2FudCB0aGUgTlRQIGNvcnJlY3RlZCB0aW1lDQpk
dXJpbmcgJ25vcm1hbCBydW5uaW5nJyBiZWNhdXNlIHRoZSBzbWFsbCBjb3JyZWN0aW9uIChmb3IN
CmNyeXN0YWwgZXJyb3IpIGlzIHVzZWZ1bC4NCg0KQnV0IHRoZSBrZXJuZWwgSFIgdGltZXJzIGFy
ZSBvbmx5IGRlZmluZWQgZm9yIENMT0NLX01PTk9UT05JQw0KYW5kIHRoZSB1c2Vyc3BhY2UgcmVx
dWVzdHMgZm9yIENMT0NLX01PTk9UT05JQ19SQVcgYXJlIGxpa2VseQ0KdG8gYmUgcmVhbCBzeXN0
ZW0gY2FsbHMuDQoNCldoYXQgeW91IHJlYWxseSB3YW50IGlzIGEgY2xvY2sgd2hvc2UgZnJlcXVl
bmN5IGlzIGFkanVzdGVkDQpieSBOVFAgYnV0IGRvZXNuJ3QgaGF2ZSB0aGUgTlRQIG9mZnNldCBh
ZGp1Y3RtZW50cy4NCkluIHJlYWxpdHkgdGhpcyBvdWdodCB0byBiZSBDTE9DS19NT05PVE9OSUMu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

