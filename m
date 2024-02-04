Return-Path: <linux-kselftest+bounces-4122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD1849020
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F3FB22827
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276324B59;
	Sun,  4 Feb 2024 19:39:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95EE250F6
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Feb 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707075598; cv=none; b=aIrSqugaFIDVkr02S3dMrtAFryoP3fQCLVN/8Oqf0acPko+H6dl8wvdJ1+dGTayMlYP5hmSZW2VLcyPWClMMPQPCPjQEW63gIZYrcZ56US1EY//deoy0MxD+HwaKroQD4+B9uG5fbVGP1Vb+C+k7AwaOyS340/igBm/ntZw7Fls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707075598; c=relaxed/simple;
	bh=f+5aNJi030Y6YvMTKjOxVL9AtdO5FkxJ4YLuhjCLqvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=gR3EqmAs9Am8K8cXZaEODjmZ+MZ5xmgd2nBsJFfuFgGS2++GykNPnhlQ0Fl02GCCpt9b4lyLJHYSlEdkPZ4eY0vkBb+c1eO3ZlMb2lRMDRXLhdxEjXLVjV1BKTTf+H3MZJWT6GsDSFPm8fUIAMmPLB1B0GcgjpsVCBXhJK2Se8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-141-bCSKLnLmOPmZ8GuKQPzVdQ-1; Sun, 04 Feb 2024 19:39:48 +0000
X-MC-Unique: bCSKLnLmOPmZ8GuKQPzVdQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 4 Feb
 2024 19:39:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 4 Feb 2024 19:39:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pedro Falcato' <pedro.falcato@gmail.com>, Jeff Xu <jeffxu@chromium.org>
CC: Theo de Raadt <deraadt@openbsd.org>, Jeff Xu <jeffxu@google.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "sroettger@google.com" <sroettger@google.com>,
	"willy@infradead.org" <willy@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "usama.anjum@collabora.com"
	<usama.anjum@collabora.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"jorgelo@chromium.org" <jorgelo@chromium.org>, "groeck@chromium.org"
	<groeck@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave.hansen@intel.com" <dave.hansen@intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v8 0/4] Introduce mseal
Thread-Topic: [PATCH v8 0/4] Introduce mseal
Thread-Index: AQHaVgr3yFwnK9gEQkCHuGFhXzylG7D6lXwg
Date: Sun, 4 Feb 2024 19:39:22 +0000
Message-ID: <acdc68a3067c437fbde184eab29924c0@AcuMS.aculab.com>
References: <20240131175027.3287009-1-jeffxu@chromium.org>
 <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver>
 <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org>
 <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
 <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com>
 <8744.1706846710@cvs.openbsd.org>
 <CABi2SkWSt=UMFWe9n916ZH16wCzaipKXmEJ5VasQHMr1AxerxQ@mail.gmail.com>
 <29248.1706850035@cvs.openbsd.org>
 <CABi2SkXPNPKgqheuFuQ9iZApQkJm8o6bypNn0B-QDz_W9b0JBQ@mail.gmail.com>
 <CAKbZUD1EsAVupRotYV-ed4PQ3sL5wM4M=f4n-6rF+QNp7C1m4g@mail.gmail.com>
In-Reply-To: <CAKbZUD1EsAVupRotYV-ed4PQ3sL5wM4M=f4n-6rF+QNp7C1m4g@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+IElNTywgVU5JWCBBUEkgZGVzaWduIGhhcyBoaXN0b3JpY2FsbHkgbW9zdGx5IGJlZW4g
InBsYXkgc3R1cGlkIGdhbWVzLA0KPiB3aW4gc3R1cGlkIHByaXplcyIsIHdoaWNoIGlzIGUuZzog
d2h5IHRoaW5ncyBsaWtlIGNsb3NlKFNURE9VVF9GSUxFTk8pDQo+IHdvcmsuIElmIHlvdSBjbG9z
ZSBzdGRvdXQgKGFuZCBkb24ndCBkdXAvcmVvcGVuIHNvbWV0aGluZyB0byBzdGRvdXQpDQo+IGFu
ZCBwcmludGYoKSwgdGhpbmdzIHdpbGwgYnJlYWssIGFuZCB5b3UgZ2V0IHRvIGtlZXAgYm90aCBw
aWVjZXMuDQoNClRoYXQgaXMgcHJldHR5IG11Y2ggd2h5IGxpYnJhcmllcyBtdXN0IG5ldmVyIHVz
ZSBwcmludGYoKS4NCihUcnkgdGVsbGluZyB0aGF0IHRvIHBlb3BsZSBhdCB3b3JrISkNCg0KSW4g
dGhlIGRheXMgd2hlbiBwcm9jZXNzZXMgY291bGQgb25seSBoYXZlIDIwIGZpbGVzIG9wZW4NCml0
IHdhcyBhIG11Y2ggYmlnZ2VyIHByb2JsZW0uDQpZb3UgY291bGRuJ3QgYWZmb3JkIHRvIG5vdCB1
c2UgMCwgMSBhbmQgMi4NCkEgY2VydGFpbiBkYWVtb24gZW5kZWQgdXAgdXNpbmcgZmQgMSBhcyBh
IHBpcGUgdG8gYW5vdGhlciBkYWVtb24uDQpTb21lb25lIGFjY2lkZW50YWxseSB1c2VkIHByaW50
ZigpIGluc3RlYWQgb2YgZnByaW50ZigpIGZvciBhIHRyYWNlLg0KV2hlbiB0aGUgMTBrIHN0ZGlv
IGJ1ZmZlciBmaWxsZWQgdGhlIHRleHQgZ290IHdyaXR0ZW4gdG8gdGhlIHBpcGUuDQpUaGUgZXhw
ZWN0ZWQgZml4ZWQgc2l6ZSBtZXNzYWdlIGhhZCBhIDMyYml0ICd0cmFpbGVyJyBzaXplLg0KQWx0
aG91Z2ggbm8gZGVmaW5lZCBtZXNzYWdlcyBzdXBwb3J0ZWQgdHJhaWxlcnMgdGhlIHNlY29uZCBk
YWVtb24NCnN5bmNocm9ub3VzbHkgZGlzY2FyZGVkIHRoZSB0cmFpbGVyIC0gd2l0aCB0aGUgZXhw
ZWN0ZWQgc2lkZSBlZmZlY3QuDQoNCldhc24ndCBteSBidWcsIGFuZCBzb21lb25lIGVsc2UgZm91
bmQgaXQsIGJ1dCBJJ2QgcmVhZCB0aGUgYnJva2VuDQpjb2RlIGEgZmV3IHRpbWVzIHdpdGhvdXQg
c2VlaW5nIHRoZSBmdWJhci4NCg0KVHJvdWJsZSBpcyBpdCBhbGwgd29ya2VkIGZvciBxdWl0ZSBh
IGxvbmcgdGltZS4uLg0KDQoJRGF2aWQNCiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


