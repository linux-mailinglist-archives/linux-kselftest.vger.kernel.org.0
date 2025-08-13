Return-Path: <linux-kselftest+bounces-38835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C90B243E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82533BFF7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFD2ED145;
	Wed, 13 Aug 2025 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euKsiIR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8292C08B3;
	Wed, 13 Aug 2025 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072878; cv=none; b=Ww3f+GfxkOHJH5Ws63doukJ7/Cwhz3h2ZHEcMC+sJ4loiGFmIMEx41B/45109040TNy2+OKTk2HHyyYDJpD64wJHeRa0LWA9qaQGgSpxFYZ/imOzqLzYoKlURNZZmSKq4PSZdFQgQA4ODwbao9+PkDm9ncVaPAUkCd5dv4hpyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072878; c=relaxed/simple;
	bh=QK+B4ggIeYqwLfgtAoxtDSY1SouaqW3O+Bn9+7thAC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8XQrDo3XNsrbpEk3Gbole3NsKXRwcnZ8XcFP2VI5acfKP2pOwLaMPfQ6m/LMHYcVQ6rowgcvFEShJSFtXUPSTGsWotumFT85ulycOD4Rarpzh1lZxhU2jmEw/ESZeur6liBaG5ccwZSGoRdNO8cHzrYGxLFDnKi70OPmN73bzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euKsiIR2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458b2d9dba5so40270745e9.1;
        Wed, 13 Aug 2025 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755072874; x=1755677674; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QK+B4ggIeYqwLfgtAoxtDSY1SouaqW3O+Bn9+7thAC4=;
        b=euKsiIR23w0uI8zEAS1EYvT2WSAo6G25+QbyD1gWKrPudNpjMPYR2zmJMMyhJTHy9I
         uNdooLAc8zQh0vZ5kN873oTj9FlqlCbErWw7IuuoZLYl12sEORIjFryhouXRGo+10eW9
         ytCmorapoUfCk3h3PsYrkTO5eibs5ttZOW859G2sPjt4JUHi0umm4WCvyHJy4bjp36wQ
         n3vCR/GcIUnR/PTK7967ulrUCO+mPpBZUzbaWYLFDvKudnNWFFSV5geKa4eHmpuGy/MN
         slZZ+U4d8JxpZu1ZG1mnOFBnpsmVYZMUk+lzE7YxoKZ/EQ1x8+o+zHauSBAJ0gVL4LW7
         QWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755072874; x=1755677674;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QK+B4ggIeYqwLfgtAoxtDSY1SouaqW3O+Bn9+7thAC4=;
        b=QUN9U1bjuUiYDTUKxhhHYFfr7IoeoHnNSbNym52bL0Kime/WeAN1CILxI4SqA9oUnb
         JJLiwUh1MGvc7y94wejiwjCtbZD9+dhj2aMzbwh1A4zqBGx5t9xv7dm1kLzTZv88aK2k
         wXyAm3W/wqoWhS56Iq3QUeSvXsq7HGSltYFAwEXgox8Sa9rD6YflrC84rnO1PWlCerZx
         tYV0v3u2eKpBIWWPX4l+ghRH2jY0Lblwnp+BbZGWGKtfakg8b1NOUTuJlc8dEef2raCn
         NOu0XxdFYzaerQv4Z7H0bMMNtU2E2yNreFbqm5cLliNNKFoRe22uYmZdLYDWs38CWUNf
         ka5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3fBXOw8ZwBIuqzzRRr+xhPVKCvyNmroDsL9RE2q+PXo9h43hBuP4//3w3pshclHI3dBQr9buMsJE2i1wP@vger.kernel.org, AJvYcCWTUZc05Wa8Gka5bxDVBS1MJ14mHG7ue8+vZPjmNxFhJh2i0DdiStY3sSmrQ8dtGj8S8ZBs3WeQNqQXehffZFie@vger.kernel.org, AJvYcCXqMeZZgOAm0MWk81+KtlEhizWZ0p4MySpZr7q4P67+3AMZj52VCf9nGHZ+Zwm9NAe0qoUu3F+4xLG1wH3UEow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/DHev96ZdohOwjQbTfrn9Lw/QdAsgU7UnaoDfgGPnXkQ1uwZ
	BsRbReoe4LuaEgyvnT1as0jsueCJTK6VFJno8Q/F3Q1jpqFg2rOsQDrM5oAntJ2MtGRM1g==
X-Gm-Gg: ASbGncuWd7v+qESP08NIbq63UA5FLRMLpO4D1N7yXE4RCQvChUBDtg4VUzUHxMhtBA8
	7TljKcbp7zrzoSBh+ee0JbvRn4RN3xlmGxxjqqzkU5DRiXm4LZpOHPgnThINRdfiKSPrvKLjJPb
	WYT6ma1IW2BudGR0spp/cKqY3kkjRmqwC6jF1wy+CIJ7gfbx2DyEW14jOF4TJkiBOgYySrigQHG
	DxpdjhupNZioC1GDL1tiQTTXzlL8XUHi0nxOKgGs0sNsvT0CSJFM8xC+ioFN1ZnsQVXMfRONkdv
	PDZ1n02SE58U839WuRBRi350zY9qch1O0f5guyYI1ax25K+AM94ak0cdIV42siL08O9p10+5+/9
	j+3W195Y+C1IR66rRlFqXhcCSVuK+
X-Google-Smtp-Source: AGHT+IGiCfhZt2+h1LjoMjjkJYyGOJ8z07EZ1hFw8yW4zOqMoQdR12QS2QYg7/b6nTNQu0Ht5AEdLA==
X-Received: by 2002:a05:600c:1c90:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45a1962e4ebmr1261065e9.16.1755072873742;
        Wed, 13 Aug 2025 01:14:33 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b916394937sm2830210f8f.6.2025.08.13.01.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 01:14:33 -0700 (PDT)
Message-ID: <569017fb-fe8d-41ff-ab23-db80a077f725@gmail.com>
Date: Wed, 13 Aug 2025 09:13:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] selftests/mm: Fix spelling mistake "mrmeap" ->
 "mremap"
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813080156.1977375-1-colin.i.king@gmail.com>
 <5a38db18-494b-4f3a-8ce4-44bab5448559@lucifer.local>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <5a38db18-494b-4f3a-8ce4-44bab5448559@lucifer.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dG5z6K4ZS0u4OAlYP03UPbK1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dG5z6K4ZS0u4OAlYP03UPbK1
Content-Type: multipart/mixed; boundary="------------WvnYaOs0IQyrYmFTW1jlqhLk";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <569017fb-fe8d-41ff-ab23-db80a077f725@gmail.com>
Subject: Re: [PATCH][next] selftests/mm: Fix spelling mistake "mrmeap" ->
 "mremap"
References: <20250813080156.1977375-1-colin.i.king@gmail.com>
 <5a38db18-494b-4f3a-8ce4-44bab5448559@lucifer.local>
In-Reply-To: <5a38db18-494b-4f3a-8ce4-44bab5448559@lucifer.local>

--------------WvnYaOs0IQyrYmFTW1jlqhLk
Content-Type: multipart/mixed; boundary="------------K4QPFvVxGPRjcuHYK2Oab8Ey"

--------------K4QPFvVxGPRjcuHYK2Oab8Ey
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpNZSB0b28gYnkgdGhlIGxvb2sgb2YgaXQuDQoNCk9uIDEzLzA4LzIwMjUgMDk6MDksIExv
cmVuem8gU3RvYWtlcyB3cm90ZToNCj4gT24gV2VkLCBBdWcgMTMsIDIwMjUgYXQgMDk6MDE6
NTZBTSArMDEwMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6DQo+PiBUaGVyZSBhcmUgc3BlbGxp
bmcgbWlzdGFrZXMgaW4gcGVycm9yIG1lc3NhZ2UuIEZpeCB0aGVzZS4NCj4gDQo+IE9vcHMg
OikgSSBhbSB0aGUgdHlwbyBtYXN0ZXIsIGFwcGFyZW50bHkuLi4NCj4gDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+DQo+
PiAtLS0NCj4+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vbXJlbWFwX3Rlc3QuYyB8
IDYgKysrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L21tL21yZW1hcF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tcmVtYXBf
dGVzdC5jDQo+PiBpbmRleCA1YmQ1MmE5NTFjYmQuLmUyODliYjExMTJkYiAxMDA2NDQNCj4+
IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL21yZW1hcF90ZXN0LmMNCj4+ICsr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL21yZW1hcF90ZXN0LmMNCj4+IEBAIC04
NDYsNyArODQ2LDcgQEAgc3RhdGljIHZvaWQgbXJlbWFwX21vdmVfbXVsdGlfaW52YWxpZF92
bWFzKEZJTEUgKm1hcHNfZnAsDQo+PiAgIAl9DQo+PiAgIAlpZiAoZXJyICE9IEVGQVVMVCkg
ew0KPj4gICAJCWVycm5vID0gZXJyOw0KPj4gLQkJcGVycm9yKCJtcm1lYXAoKSB1bmV4cGVj
dGVkIGVycm9yIik7DQo+PiArCQlwZXJyb3IoIm1yZW1hcCgpIHVuZXhwZWN0ZWQgZXJyb3Ii
KTsNCj4+ICAgCQlzdWNjZXNzID0gZmFsc2U7DQo+PiAgIAkJZ290byBvdXRfdW5tYXA7DQo+
PiAgIAl9DQo+PiBAQCAtODk5LDcgKzg5OSw3IEBAIHN0YXRpYyB2b2lkIG1yZW1hcF9tb3Zl
X211bHRpX2ludmFsaWRfdm1hcyhGSUxFICptYXBzX2ZwLA0KPj4gICAJfQ0KPj4gICAJaWYg
KGVyciAhPSBFRkFVTFQpIHsNCj4+ICAgCQllcnJubyA9IGVycjsNCj4+IC0JCXBlcnJvcigi
bXJtZWFwKCkgdW5leHBlY3RlZCBlcnJvciIpOw0KPj4gKwkJcGVycm9yKCJyZW1hcHAoKSB1
bmV4cGVjdGVkIGVycm9yIik7DQo+IA0KPiBUeXBvIGluIHRoZSB0eXBvIGZpeHVwIDpQIHNo
b3VsZCBiZToNCj4gDQo+IAkJcGVycm9yKCJtcmVtYXAoKSB1bmV4cGVjdGVkIGVycm9yIik7
DQo+IA0KPj4gICAJCXN1Y2Nlc3MgPSBmYWxzZTsNCj4+ICAgCQlnb3RvIG91dF91bm1hcDsN
Cj4+ICAgCX0NCj4+IEBAIC05NDgsNyArOTQ4LDcgQEAgc3RhdGljIHZvaWQgbXJlbWFwX21v
dmVfbXVsdGlfaW52YWxpZF92bWFzKEZJTEUgKm1hcHNfZnAsDQo+PiAgIAl9DQo+PiAgIAlp
ZiAoZXJyICE9IEVGQVVMVCkgew0KPj4gICAJCWVycm5vID0gZXJyOw0KPj4gLQkJcGVycm9y
KCJtcm1lYXAoKSB1bmV4cGVjdGVkIGVycm9yIik7DQo+PiArCQlwZXJyb3IoInJlbWFwcCgp
IHVuZXhwZWN0ZWQgZXJyb3IiKTsNCj4gDQo+IEVxdWFsbHkgc2hvdWxkIGJlOg0KPiANCj4g
CQlwZXJyb3IoIm1yZW1hcCgpIHVuZXhwZWN0ZWQgZXJyb3IiKTsNCj4gDQo+PiAgIAkJc3Vj
Y2VzcyA9IGZhbHNlOw0KPj4gICAJCWdvdG8gb3V0X3VubWFwOw0KPj4gICAJfQ0KPj4gLS0N
Cj4+IDIuNTAuMQ0KPj4NCj4gDQo+IENoZWVycywgTG9yZW56bw0KDQo=
--------------K4QPFvVxGPRjcuHYK2Oab8Ey
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------K4QPFvVxGPRjcuHYK2Oab8Ey--

--------------WvnYaOs0IQyrYmFTW1jlqhLk--

--------------dG5z6K4ZS0u4OAlYP03UPbK1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmicSUEFAwAAAAAACgkQaMKH38aoAiZV
+A/+KZyA3gOQUberwfiLI9HeQM3oBLDcVxCDsZumFvLeZ6xl/nYSJb3TpJrn+yv8VZDI+lXpPSFw
4wKLzD3omBQLJog4erB3HcC3upiWRht44QHDH3Py5b+q9GITqsGLKDTqvwwlHzvvWevWkOeftVGK
2q8SW8wcJ4Y4BvZF0Q9h+YkN8+nnLmQMWoQRA/xPfGxz1A8r0z6AgV26Jd8yWc3w5UB5fJlMoZfF
lEZ/iLYhUuWo5/fbTnehz1bAuOMTYZ5QE+IXmNZgnne8JGKCmIUW6vqJCFotOBY96ihIZPp9VzYK
5ZtejRn4PGGpXdPxkuItGuEnZIrxeeS7fUIrC/DXoyYrWUtU6TwzIP9P3aFdLHtLWOZtUcuGeSBK
t9ek1zjbDLgLm2WiRKpNBtkbS2hG3RdyDY/T1nRPZA+uYLU7n2SuzT7Be40vQ62i0aqB/X6ipCHd
r6ME4ffxNAcxWZKxVvR7VaQd+BYt+dk661zTdVn8Cd1xAAbduvDe7fCEzQvtyCVgEvzHQJ6opboe
ifGXkSFsny/ALa3j46//TR/0qAkCG83BBZH1ZRhMsBUWTzdXnydNJd8q8lgtNnCxcDHS4ZzzlUa5
DcS+20EbIWJ+AEkQnq+WAL50Fc+x6C8pl3j+OniYk+wCXwLCxHYaz9gqf7RtekFL2betBWDmoHkK
uF4=
=Iu9R
-----END PGP SIGNATURE-----

--------------dG5z6K4ZS0u4OAlYP03UPbK1--

