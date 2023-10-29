Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C227DAE75
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Oct 2023 22:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJ2VNf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Oct 2023 17:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2VNf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Oct 2023 17:13:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E529C0
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Oct 2023 14:13:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-P37uwYhsMfGigzGfDc7VcA-1; Sun, 29 Oct 2023 21:13:29 +0000
X-MC-Unique: P37uwYhsMfGigzGfDc7VcA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 21:13:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 29 Oct 2023 21:13:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Woodhouse' <dwmw2@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: selftests: add -MP to CFLAGS
Thread-Topic: [PATCH] KVM: selftests: add -MP to CFLAGS
Thread-Index: AQHaCdXc3e78bpbjnkOmWxrFAzERRLBhRPEw
Date:   Sun, 29 Oct 2023 21:13:41 +0000
Message-ID: <3fa5bdded7504d6582cf01f4db4cd6b4@AcuMS.aculab.com>
References: <9fc8b5395321abbfcaf5d78477a9a7cd350b08e4.camel@infradead.org>
In-Reply-To: <9fc8b5395321abbfcaf5d78477a9a7cd350b08e4.camel@infradead.org>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RnJvbTogRGF2aWQgV29vZGhvdXNlDQo+IFNlbnQ6IDI4IE9jdG9iZXIgMjAyMyAyMDozNQ0KPiAN
Cj4gVXNpbmcgLU1EIHdpdGhvdXQgLU1QIGNhdXNlcyBidWlsZCBmYWlsdXJlcyB3aGVuIGEgaGVh
ZGVyIGZpbGUgaXMgZGVsZXRlZA0KPiBvciBtb3ZlZC4gV2l0aCAtTVAsIHRoZSBjb21waWxlciB3
aWxsIGVtaXQgcGhvbnkgdGFyZ2V0cyBmb3IgdGhlIGhlYWRlcg0KPiBmaWxlcyBpdCBsaXN0cyBh
cyBkZXBlbmRlbmNpZXMsIGFuZCB0aGUgTWFrZWZpbGVzIHdvbid0IHJlZnVzZSB0byBhdHRlbXB0
DQo+IHRvIHJlYnVpbGQgYSBDIHVuaXQgd2hpY2ggbm8gbG9uZ2VyIGluY2x1ZGVzIHRoZSBkZWxl
dGVkIGhlYWRlci4NCg0KV29uJ3QgYSBwaG9ueSB0YXJnZXQgc3RvcCBhIGhlYWRlciBiZWluZyBi
dWlsdCBpZiB0aGVyZSBpcw0KYW4gYWN0dWFsIHJ1bGUgdG8gYnVpbGQgaXQ/DQoNCkkgdXN1YWxs
eSBhZGQ6DQoNCiUuaDoNCgllY2hvICJJZ25vcmluZyBzdGFsZSBkZXBlbmRlbmN5IGZvciAkQCIN
Cg0KV2hpY2ggb25seSBhcHBsaWVzIGlmIHRoZXJlIGlzbid0IGFuIGV4cGxpY2l0IHJ1bGUuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

