Return-Path: <linux-kselftest+bounces-18253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D519097F13F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94821283033
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057581A08AD;
	Mon, 23 Sep 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="b/pTkeh+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED41A01DB;
	Mon, 23 Sep 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120300; cv=none; b=PPbOPcsWLkfSqqntG2jGSVvP2T4KaD42+zrbFGRow9mQSHTZ8JauBoTq+WiOd6032QtMpeb27SAI/1ej7ENNMBZ9VpfU2LL3xmKqUbUaS2TZubjxcrukif/SD0esMqZt6QBopjU7vbihfa5Vw02AufddQmmy+NotpSmGQd+jTM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120300; c=relaxed/simple;
	bh=grqQ2CjIKLSlKeeiwn65dnGWQ0uGMcclQOKXorFKyls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uo18yCTgXHmYQqCHSjzmUJ61zlwMUjSQTry7RADaeumY19gsgWBj2l+qxjSBMDrMquMCNp2Y3uuyMsyt7myA8gV6c8bCVhhQShsKdeQJgLCG/RA6LeSqAUvxPOPtv/WFa66jGsgmqnY851X2XaOqJ41EQgR8kQLnsj75YRpnFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=b/pTkeh+; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1727120299; x=1758656299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=grqQ2CjIKLSlKeeiwn65dnGWQ0uGMcclQOKXorFKyls=;
  b=b/pTkeh+iksjyF6gWwHWP3jBPgio9TBmEK5kqo/S2SOdZNrgmMEn2BS1
   KD/rnMkskJUfw6zySSA3gMYJM/Yk/KC0lNwZWIKhgt1N7Ba9MXtwdpwQ8
   07461Y2mztVtbkFCms34w21/JT+Dci1XOsxb2imZf6u5pWOj9fq4zN4sx
   A=;
X-IronPort-AV: E=Sophos;i="6.10,252,1719878400"; 
   d="scan'208";a="129520098"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:38:16 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:8558]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.19:2525] with esmtp (Farcaster)
 id b7fcc6fb-aaa7-420b-bfc5-c3426350a70e; Mon, 23 Sep 2024 19:38:15 +0000 (UTC)
X-Farcaster-Flow-ID: b7fcc6fb-aaa7-420b-bfc5-c3426350a70e
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 19:38:14 +0000
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 19:38:14 +0000
Received: from EX19D033EUC004.ant.amazon.com ([fe80::8359:4d84:fb19:f6e9]) by
 EX19D033EUC004.ant.amazon.com ([fe80::8359:4d84:fb19:f6e9%3]) with mapi id
 15.02.1258.034; Mon, 23 Sep 2024 19:38:14 +0000
From: "Allister, Jack" <jalliste@amazon.co.uk>
To: "Orlov, Ivan" <iorlov@amazon.co.uk>, "seanjc@google.com"
	<seanjc@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Allister, Jack" <jalliste@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nh-open-source@amazon.com"
	<nh-open-source@amazon.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
Thread-Topic: [PATCH 0/4] Process some MMIO-related errors without KVM exit
Thread-Index: AQHbDfAhxllj9BkSGESVxhja3HYLgg==
Date: Mon, 23 Sep 2024 19:38:14 +0000
Message-ID: <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
References: <20240923141810.76331-1-iorlov@amazon.com>
	 <ZvGfnARMqZS0mkg-@google.com>
In-Reply-To: <ZvGfnARMqZS0mkg-@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BE0B8284999B4479E5855E2BA02CE25@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA5LTIzIGF0IDEwOjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQsIEl2YW4gT3Jsb3Ygd3JvdGU6DQo+ID4g
Q3VycmVudGx5LCBLVk0gbWF5IHJldHVybiBhIHZhcmlldHkgb2YgaW50ZXJuYWwgZXJyb3JzIHRv
IFZNTSB3aGVuDQo+ID4gYWNjZXNzaW5nIE1NSU8sIGFuZCBzb21lIG9mIHRoZW0gY291bGQgYmUg
Z3JhY2VmdWxseSBoYW5kbGVkIG9uIHRoZQ0KPiA+IEtWTQ0KPiA+IGxldmVsIGluc3RlYWQuIE1v
cmVvdmVyLCBzb21lIG9mIHRoZSBNTUlPLXJlbGF0ZWQgZXJyb3JzIGFyZQ0KPiA+IGhhbmRsZWQN
Cj4gPiBkaWZmZXJlbnRseSBpbiBWTVggaW4gY29tcGFyaXNvbiB3aXRoIFNWTSwgd2hpY2ggcHJv
ZHVjZXMgY2VydGFpbg0KPiA+IGluY29uc2lzdGVuY3kgYW5kIHNob3VsZCBiZSBmaXhlZC4gVGhp
cyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcw0KPiA+IEtWTS1sZXZlbCBoYW5kbGluZyBmb3IgdGhl
IGZvbGxvd2luZyBzaXR1YXRpb25zOg0KPiA+IA0KPiA+IDEpIEd1ZXN0IGlzIGFjY2Vzc2luZyBN
TUlPIGR1cmluZyBldmVudCBkZWxpdmVyeTogdHJpcGxlIGZhdWx0DQo+ID4gaW5zdGVhZA0KPiA+
IG9mIGludGVybmFsIGVycm9yIG9uIFZNWCBhbmQgaW5maW5pdGUgbG9vcCBvbiBTVk0NCj4gPiAN
Cj4gPiAyKSBHdWVzdCBmZXRjaGVzIGFuIGluc3RydWN0aW9uIGZyb20gTU1JTzogaW5qZWN0ICNV
RCBhbmQgcmVzdW1lDQo+ID4gZ3Vlc3QNCj4gPiBleGVjdXRpb24gd2l0aG91dCBpbnRlcm5hbCBl
cnJvcg0KPiANCj4gTm8uwqAgVGhpcyBpcyBub3QgYXJjaGl0ZWN0dXJhbCBiZWhhdmlvci7CoCBJ
dCdzIG5vdCBldmVuIHJlbW90ZWx5DQo+IGNsb3NlIHRvDQo+IGFyY2hpdGVjdHVyYWwgYmVoYXZp
b3IuwqAgS1ZNJ3MgYmVoYXZpb3IgaXNuJ3QgZ3JlYXQsIGJ1dCBtYWtpbmcgdXANCj4gX2d1ZXN0
IHZpc2libGVfDQo+IGJlaGF2aW9yIGlzIG5vdCBnb2luZyB0byBoYXBwZW4uDQoNCklzIHRoaXMg
YSBubyB0byB0aGUgd2hvbGUgc2VyaWVzIG9yIGZyb20gdGhlIGNvdmVyIGxldHRlcj/CoA0KDQpG
b3IgcGF0Y2ggMSB3ZSBoYXZlIG9ic2VydmVkIHRoYXQgaWYgYSBndWVzdCBoYXMgaW5jb3JyZWN0
bHkgc2V0IGl0J3MNCklEVCBiYXNlIHRvIHBvaW50IGluc2lkZcKgb2YgYW4gTU1JTyByZWdpb24g
aXQgd2lsbCByZXN1bHQgaW4gYSB0cmlwbGUNCmZhdWx0IChiYXJlIG1ldGFsIENhc2Nha2UgTGFr
ZSBJbnRlbCkuIFllcyBhIHNhbmUgb3BlcmF0aW5nIHN5c3RlbSBpcw0Kbm90IHJlYWxseSBnb2lu
ZyB0byBiZSBkb2luZyBzZXR0aW5nIGl0J3MgSURUIG9yIEdEVCBiYXNlIHRvIHBvaW50IGludG8N
CmFuIE1NSU8gcmVnaW9uLCBidXQgd2UndmUgc2VlbiBvY2N1cnJlbmNlcy4gTm9ybWFsbHkgd2hl
biBvdGhlcg0KZXh0ZXJuYWwgdGhpbmdzIGhhdmUgZ29uZSBob3JyaWJseSB3cm9uZy4NCg0KSXZh
biBjYW4gY2xhcmlmeSBhcyB0byB3aGF0J3MgYmVlbiBzZWVuIG9uIEFNRCBwbGF0Zm9ybXMgcmVn
YXJkaW5nIHRoZQ0KaW5maW5pdGUgbG9vcCBmb3IgcGF0Y2ggb25lLiBUaGlzIHdhcyBhbHNvIHRl
c3RlZCBvbiBiYXJlIG1ldGFsDQpoYXJkd2FyZS4gSW5qZWN0aW9uIG9mIHRoZSAjVUQgd2l0aGlu
IHBhdGNoIDIgbWF5IGJlIGRlYmF0YWJsZSBidXQgSQ0KYmVsaWV2ZSBJdmFuIGhhcyBzb21lIG1v
cmUgZGF0YSBmcm9tIGV4cGVyaW1lbnRzIGJhY2tpbmcgdGhpcyB1cC4NCg0KQmVzdCByZWdhcmRz
LA0KSmFjaw0KDQoNCg0K

