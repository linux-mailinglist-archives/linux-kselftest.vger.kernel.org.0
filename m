Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F030D40BFDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 08:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhIOG4J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 02:56:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3808 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbhIOG4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 02:56:04 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8W9c0BTkz67Jjw;
        Wed, 15 Sep 2021 14:52:20 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 08:54:43 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.008;
 Wed, 15 Sep 2021 08:54:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@iki.fi>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 01/13] diglim: Overview
Thread-Topic: [PATCH v3 01/13] diglim: Overview
Thread-Index: AQHXqYZfRxnX/6KOFkyr4fwMQ3melaujn2qAgAEJqYA=
Date:   Wed, 15 Sep 2021 06:54:43 +0000
Message-ID: <d6895db82ec440338b75821b5f1d0131@huawei.com>
References: <20210914163401.864635-1-roberto.sassu@huawei.com>
         <20210914163401.864635-2-roberto.sassu@huawei.com>
 <d642b9c5e2bef4a76535627dc84e76073078bf7e.camel@iki.fi>
In-Reply-To: <d642b9c5e2bef4a76535627dc84e76073078bf7e.camel@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXJra28gU2Fra2luZW4gW21haWx0bzpqYXJra28uc2Fra2luZW5AaWtpLmZpXQ0K
PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjEgNzowMCBQTQ0KPiBPbiBUdWUsIDIw
MjEtMDktMTQgYXQgMTg6MzMgKzAyMDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gQWRkIGFu
IG92ZXJ2aWV3IG9mIERJR0xJTSB0bw0KPiBEb2N1bWVudGF0aW9uL3NlY3VyaXR5L2RpZ2xpbS9p
bnRyb2R1Y3Rpb24ucnN0DQo+ID4gYW5kIHRoZSBhcmNoaXRlY3R1cmUgdG8gRG9jdW1lbnRhdGlv
bi9zZWN1cml0eS9kaWdsaW0vYXJjaGl0ZWN0dXJlLnJzdA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiANCj4gWW91IGNv
dWxkIGJyb2FkbHkgZGVzY3JpYmUgd2hhdCBESUdMSU0gaXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KDQpIaSBKYXJra28NCg0KSSBjb3VsZCBhZGQgdGhlIGZpcnN0IHNlbnRlbmNlIGluIGludHJv
ZHVjdGlvbi5yc3QuDQoNCj4gV2hhdCBkbyB5b3UgbWVhbiBieSBhcmNoaXRlY3R1cmU/IEtlcm5l
bCBpbXBsZW1lbnRhdGlvbiwgb3Igc29tZXRoaW5nDQo+IGVsc2U/DQoNCkJ5IGFyY2hpdGVjdHVy
ZSBJIG1lYW4gaGlnaCBsZXZlbCBkZXNpZ24gd2l0aCBjb21wb25lbnRzIGFuZA0KcmVsYXRpb25z
aGlwIGJldHdlZW4gdGhlbS4NCg0KTG93IGxldmVsIGRldGFpbHMgYXJlIGluY2x1ZGVkIGluIGlt
cGxlbWVudGF0aW9uLnJzdC4NCg0KVGhhbmtzDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xP
R0lFUyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQ
ZW5nLCBaaG9uZyBSb25naHVhDQo=
