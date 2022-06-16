Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B054ECDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 23:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378169AbiFPVy0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiFPVyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 17:54:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED71D57143
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 14:54:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-62-astVriicPDe5cx5R_yDGqw-1; Thu, 16 Jun 2022 22:54:18 +0100
X-MC-Unique: astVriicPDe5cx5R_yDGqw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 16 Jun 2022 22:54:16 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 16 Jun 2022 22:54:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'oliver.upton@linux.dev'" <oliver.upton@linux.dev>
CC:     Raghavendra Rao Ananta <rananta@google.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        "Ricardo Koller" <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        "Reiji Watanabe" <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Colton Lewis" <coltonlewis@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Andrew Jones" <drjones@redhat.com>
Subject: RE: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Thread-Topic: [PATCH] selftests: KVM: Handle compiler optimizations in ucall
Thread-Index: AQHYgXkNkdHi2edO0UOJoWwOrv/ni61SMGPg///3a4CAABX/cIAAENKAgABDjYA=
Date:   Thu, 16 Jun 2022 21:54:16 +0000
Message-ID: <2ec9ecbfb13d422ab6cda355ff011c9f@AcuMS.aculab.com>
References: <3e73cb07968d4c92b797781b037c2d45@AcuMS.aculab.com>
 <20220615185706.1099208-1-rananta@google.com>
 <20220616120232.ctkekviusrozqpru@gator>
 <33ca91aeb5254831a88e187ff8d9a2c2@AcuMS.aculab.com>
 <20220616162557.55bopzfa6glusuh5@gator>
 <7b1040c48bc9b2986798322c336660ab@linux.dev>
In-Reply-To: <7b1040c48bc9b2986798322c336660ab@linux.dev>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogb2xpdmVyLnVwdG9uQGxpbnV4LmRldg0KPiBTZW50OiAxNiBKdW5lIDIwMjIgMTk6NDUN
Cg0KPiANCj4gSnVuZSAxNiwgMjAyMiAxMTo0OCBBTSwgIkRhdmlkIExhaWdodCIgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPiBObyB3b25kZXIgSSB3YXMgY29uZnVzZWQuDQo+
ID4gSXQncyBub3Qgc3VycHJpc2luZyB0aGUgY29tcGlsZXIgb3B0aW1pc2VzIGl0IGFsbCBhd2F5
Lg0KPiA+DQo+ID4gSXQgZG9lc24ndCBzZWVtIHJpZ2h0IHRvIGJlICdhYnVzaW5nJyBXUklURV9P
TkNFKCkgaGVyZS4NCj4gPiBKdXN0IGFkZGluZyBiYXJyaWVyKCkgc2hvdWxkIGJlIGVub3VnaCBh
bmQgbXVjaCBtb3JlIGRlc2NyaXB0aXZlLg0KPiANCj4gSSBoYWQgdGhlIHNhbWUgdGhvdWdodCwg
YWx0aG91Z2ggSSBkbyBub3QgYmVsaWV2ZSBiYXJyaWVyKCkgaXMgc3VmZmljaWVudA0KPiBvbiBp
dHMgb3duLiBiYXJyaWVyX2RhdGEoKSB3aXRoIGEgcG9pbnRlciB0byB1YyBwYXNzZWQgdGhyb3Vn
aA0KPiBpcyByZXF1aXJlZCB0byBrZWVwIGNsYW5nIGZyb20gZWxpbWluYXRpbmcgdGhlIGRlYWQg
c3RvcmUuDQoNCkEgYmFycmllcigpIChmdWxsIG1lbW9yeSBjbG9iYmVyKSBvdWdodCB0byBiZSBz
dHJvbmdlciB0aGFuDQp0aGUgcGFydGlhbCBvbmUgdGhhbiBiYXJyaWVyX2RhdGEoKSBnZW5lcmF0
ZXMuDQoNCkkgY2FuJ3QgcXVpdGUgZGVjaWRlIHdoZXRoZXIgeW91IG5lZWQgYSBiYXJyaWVyKCkg
Ym90aCBzaWRlcw0Kb2YgdGhlICdtYWdpYyB3cml0ZScuDQpQbGF1c2libHkgdGhlIGNvbXBpbGVy
IGNvdWxkIGRpc2NhcmQgdGhlIG9uLXN0YWNrIGRhdGENCmFmdGVyIHRoZSBiYXJyaWVyKCkgYW5k
IGJlZm9yZSB0aGUgJ21hZ2ljIHdyaXRlJy4NCg0KQ2VydGFpbmx5IHB1dHRpbmcgdGhlICdtYWdp
YyB3cml0ZScgaW5zaWRlIGEgYXNtIGJsb2NrDQp0aGF0IGhhcyBhIG1lbW9yeSBjbG9iYmVyIGlz
IGEgbW9yZSBjb3JyZWN0IHNvbHV0aW9uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

