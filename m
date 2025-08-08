Return-Path: <linux-kselftest+bounces-38550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A97B1E6EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 13:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4960F5679D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727B3145329;
	Fri,  8 Aug 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVEHT+cS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378E53BE;
	Fri,  8 Aug 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650952; cv=none; b=i1NItvYIs97JAk6ny1Pxf8iSKLajsTiBjqpy39qtTDYtOSyOc7IYbLMTDHpDjErPR6SBV9v8WR/hi2YytCHe3CVNOmnTvo/1nrY90Myqjcp0Wbx+WCLLTralQ0pItTtoSabpbBlztKejRzWiBXYmQ6aoC5eNlcJ1c62QxbO/uSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650952; c=relaxed/simple;
	bh=RmmuKt0hIeHd0T2y+ILY7F4VubBes3zq835VLwGRMP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtpjIWU6PPV3M5EYaArw/gQVjpwFXkNwdPsM6FqE05kWwxwAkqGrFWZ9KoE07eQErMbPJoEl4HFGseMg9DOpXcFeSOjsjdTtHGFXDnWFmwaq6bgvwWucalKwTHhgFLjy1VPZHzQZpgTyqQG0wjut2lbGu3NfgfjrBULbbMtUJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVEHT+cS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459e1338565so18401445e9.2;
        Fri, 08 Aug 2025 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754650949; x=1755255749; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RmmuKt0hIeHd0T2y+ILY7F4VubBes3zq835VLwGRMP8=;
        b=YVEHT+cSl5PBswEXamCfFmf9d2w7RXxHGDawdhEOoRkgydozSBViNLsRSXuOssf8cf
         7SKQCCdHJxIG1upXSmw4RFVazwQuKY3lHWl8Lo0Tdz+e1ABg0U3ogjoSCEsVxQeOybzw
         2cFkGQSjALUqcN5Z2ojTbrJpEw0dOTwmdhiO6y+UjNNTnE0pdcm7vTiiuLOcmxaH8+XO
         TjAsKjBFPcgqIoDAmP9bTmC6Ql5SD1cRXDuSSMfo3Zz30Kh5Gqkxdf8fJZYicliAW4dF
         Vr1E1yx1xEcEaJ93VLMpBRdOKJp7WxJTF2s8hZzlUuP9xGa5b2YbWhfaaQZ52CuKuRE4
         zDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650949; x=1755255749;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmmuKt0hIeHd0T2y+ILY7F4VubBes3zq835VLwGRMP8=;
        b=PltyiHkzavwWa3kjpbNbBP4B/o4ADDmhgOrQhUOFP8QaOfGkybd4mnx+w3YgP7L0Tg
         AriKZNaKK0rB2eYSxKNdXEB65q03/7FJyObjsCoHcHWIOQouCi1nvjnE3dgO44o9sus2
         zeOXBpYIhGip6I7tu4R994DipzJdPa8qmKVHRItHr8pTtwThvXNuK6uBVsDGFMjMvgqD
         u3aioEyvY4LR+7a9qMh1Egv5T9qvhUKNX9aECrvYcJEO4BexdmZeFhm6uubbcVmRLBMY
         ao5avceoFX1tmgTUB+4a237aXR2+p3mis6TaGmqDaPuIIsEoc6kuu9gF/vKBTlk1XOZr
         YbyA==
X-Forwarded-Encrypted: i=1; AJvYcCVcfG0Zl0X1Qj+iBtBCAmk8J57e2NGfxalle+fKJhFyx3lybET+emUS2CCC2eZ2eoLXuofrapLTwPVeQTg=@vger.kernel.org, AJvYcCXcHAgydUuIT2QGn7I9pnhKgTSSWDMOm44/B9NJsJB9+DM/bAJsTB82W60nhEFqnBNpSJH/qYq/IYOdIW/BHuDx@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHPN4WZB3wkq06XSUNwCbbFz9pdyYeZiX7PG0vefHJbGyCiky
	i5MH0t6uYxPbyHYRvDM6e2EClH8g2pPtYB37HzximERMXahMlQcdtgv4kM5PBGHpU/Oi5w==
X-Gm-Gg: ASbGnctY6qyphv1pPqOJGRci5O3byufXKBlTDcw650RjE3u+6uSECPyWIhVtcn5bwxa
	Hz2lMbrj7CciqacaU7mhVmCn7KCrLi6YQ/C0tqvE4+XMt10rhL2MS2LD8aW5alQGfedRihYl88u
	KHLM5ByAVn9TfWL00gLTHPmkPPlgfTDDknhwKsw4A9uMjPeam56GE5yAblCFZZaWjdLqSkPEws5
	Fm1mbtBCW8z6YWhfG016qmuc2arkFogVPydnJsUSGTr4dJLbXkRwT6jHSGcK4v/emGg0yR4NrHn
	xJCpfAT75m6+J+R6d8/E0Y0cHW4F8VQgjoJfaL8l10zMLMMOqQQibpeCGGL5SV2VRlKn+Qu8BI3
	DEX6LIIHa2FLCy4zCo6lAqMpdTTfc
X-Google-Smtp-Source: AGHT+IEq2UaSLkYFNiWyhn4TanyJ+n5eqFAJ55Bp3afmagV4IiK/syvM4uIfB9gp5M7/SXmOY6mFXQ==
X-Received: by 2002:a05:6000:4587:b0:3b8:d14b:8f86 with SMTP id ffacd0b85a97d-3b900b79412mr1644572f8f.45.1754650948890;
        Fri, 08 Aug 2025 04:02:28 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm29752691f8f.10.2025.08.08.04.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:02:28 -0700 (PDT)
Message-ID: <358d6fae-80be-469c-a8d9-c4e786781a65@gmail.com>
Date: Fri, 8 Aug 2025 12:01:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests/futex: issue with -g option help text
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>
 <20250808105435.PYwBvZ-6@linutronix.de>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <20250808105435.PYwBvZ-6@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pNh6BqJIU9bsPMWAqI56GN1S"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pNh6BqJIU9bsPMWAqI56GN1S
Content-Type: multipart/mixed; boundary="------------bME364WCHSOYRLIvkjKLnc8C";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <358d6fae-80be-469c-a8d9-c4e786781a65@gmail.com>
Subject: Re: selftests/futex: issue with -g option help text
References: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>
 <20250808105435.PYwBvZ-6@linutronix.de>
In-Reply-To: <20250808105435.PYwBvZ-6@linutronix.de>

--------------bME364WCHSOYRLIvkjKLnc8C
Content-Type: multipart/mixed; boundary="------------KJPW0okQmqgAIdblAxNqPU3S"

--------------KJPW0okQmqgAIdblAxNqPU3S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDA4LzA4LzIwMjUgMTE6NTQsIFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3Ig
d3JvdGU6DQo+IE9uIDIwMjUtMDgtMDggMTE6NDA6MjMgWyswMTAwXSwgQ29saW4gS2luZyAo
Z21haWwpIHdyb3RlOg0KPj4gSGksDQo+IEhpLA0KPiANCj4+IE5hbWVseToNCj4+DQo+PiBz
dGF0aWMgdm9pZCB1c2FnZShjaGFyICpwcm9nKQ0KPj4gew0KPj4gICAgICAgICAgcHJpbnRm
KCJVc2FnZTogJXNcbiIsIHByb2cpOw0KPj4gICAgICAgICAgcHJpbnRmKCIgIC1jICAgIFVz
ZSBjb2xvclxuIik7DQo+PiAgICAgICAgICBwcmludGYoIiAgLWcgICAgVGVzdCBnbG9iYWwg
aGFzaCBpbnN0ZWFkIGludGVhZCBsb2NhbCBpbW11dGFibGUNCj4+IFxuIik7DQo+PiAgICAg
ICAgICBwcmludGYoIiAgLWggICAgRGlzcGxheSB0aGlzIGhlbHAgbWVzc2FnZVxuIik7DQo+
PiAgICAgICAgICBwcmludGYoIiAgLXYgTCAgVmVyYm9zaXR5IGxldmVsOiAlZD1RVUlFVCAl
ZD1DUklUSUNBTCAlZD1JTkZPXG4iLA0KPj4gICAgICAgICAgICAgICAgIFZRVUlFVCwgVkNS
SVRJQ0FMLCBWSU5GTyk7DQo+PiB9DQo+Pg0KPj4NCj4+IHRoZXJlIHdvcmQgImludGVhZCIg
Zm9yIHRoZSAtZyBvcHRpb24gc2hvdWxkIGJlIHJlbW92ZWQsIGJ1dCBJJ20gYWxzbw0KPj4g
ZmluZGluZyB0aGUgcmVzdWx0aW5nIHRleHQgaGFyZCB0byBwYXJzZSwgcGVyaGFwcyBpdCBu
ZWVkcyB0byBiZSByZXBocmFzZWQ/DQo+IA0KPiAgICAgVGVzdCBnbG9iYWwgaGFzaCBpbnN0
ZWFkIGluc3RlYWQgcHJpdmF0ZSBoYXNoDQoNClN1cmVseToNCglUZXN0IGdsb2JhbCBoYXNo
IGluc3RlYWQgb2YgcHJpdmF0ZSBoYXNoDQoNCj4gDQo+ID8NCj4gDQo+PiBDb2xpbg0KPiAN
Cj4gU2ViYXN0aWFuDQoNCg==
--------------KJPW0okQmqgAIdblAxNqPU3S
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

--------------KJPW0okQmqgAIdblAxNqPU3S--

--------------bME364WCHSOYRLIvkjKLnc8C--

--------------pNh6BqJIU9bsPMWAqI56GN1S
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmiV2R4FAwAAAAAACgkQaMKH38aoAiar
4g//emkN+AlYRfktYwW0l5+eax4sX7Y1w7RsQo4eDYaVsE2+AnGGvI/lkxzDhaEr5pVWnMGCzJff
mxsCKXuTkQdMZcHg39xaGnmPQtQ+kgMXIcrbalhkWibyhb9VfJ2xSuYMzzROqwMXr1pQBbWK6vGu
6nXw5svYQEmmK/KmflfiYXJPOfNy5tCz9AMK2prvD1N6QIAe0WcNjafMjGVCGsTLzMOAu0963b3y
xNuCyILtlX0j3RtbwXqadKi++byGqSBDPtRvHqJ20T/bznu2IxIH/d8AvnaxxBpiBTUzh1MVmyDV
7JSNclS1ggyGY+yN38Izk8/X0uOZWaqVvsebg9srM22bdKTW0ihZ17toTaGoBuUbXdr92gGS6puZ
RZOOin38tThVIffCuroWxk3M7P0xJfmsE1xhlmU4v8LxScqdcfCFxhDy1mpIb0zLBChYapwL/cQm
OGZ/Vs2yqEjbXXakRhkQB5OyJJYaoZwYfG28eWQxxJLgtH3Z4sE4leK+nCE+xH0BPdZ3yfkekRqR
kvNJT8MCmlbdF6fNGm67UamdEVXU61w3L+Vlr5Jceb44mpTVwJtk73gPPIzOxRXfTBA2XETzSU9J
My3LHgkL7Do7T0TJwIYm4qurd5WLc1f604Z++koBtIO8DSR0/Fu4XrnW71kjo2h6zMURIP51oloR
5s0=
=iksK
-----END PGP SIGNATURE-----

--------------pNh6BqJIU9bsPMWAqI56GN1S--

