Return-Path: <linux-kselftest+bounces-38548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3BB1E697
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 12:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74772164ECE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90961274674;
	Fri,  8 Aug 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKrnWamW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D555D273D6C;
	Fri,  8 Aug 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649665; cv=none; b=Row0Xs6CyE6WWrgMy9F8a3EJTacAkOVDvo7wJ2d86C0lUe1a6t76BZuV94zMNvGP0uC6qgciUvHIKDr8h1Tfo0ITv3qoKwmhmwZngnZzZOdxYOWfK3RKvRrMQqAZHjIqO3lPRb/76Yc9IG0i3Ud89RQTfBW8MHMno5yF2qlam24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649665; c=relaxed/simple;
	bh=p9DdjsBRQR9fIuAo8ImDGM1JqWF+CTi8v4E1obmb+Oo=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Z9tTtpy6TVw83uF/Ep8X5gtBXzTgkH8lRP9avJ0TktzTDEmYox38/crYAOzSBJGjvO+P9ToaGFAthC94xS2VzT0fFv4qbflVsCi9OoohoYxm3z84mPhJDW32PvfzRPcjSlW0IsR93zV7gAMO0nYC4evqCgoEvPoS9ZQV5f2DyMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKrnWamW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so2000829f8f.1;
        Fri, 08 Aug 2025 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754649662; x=1755254462; darn=vger.kernel.org;
        h=subject:cc:autocrypt:to:content-language:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9DdjsBRQR9fIuAo8ImDGM1JqWF+CTi8v4E1obmb+Oo=;
        b=nKrnWamW8MjxxU4B5V/u41xpslLU7DyuqerlgykIF5DtPjj/GRnoNczHrgJdkzXODR
         PWOdh+YC/mxT9BfO7ASsLwrNjxRgV59P/FkU8dM6iJu4uLEHvpZITCEbsQakom5YkXh1
         fS2U9tEVyq1znaTCTdeUbZG9IBS+0O86IAU9MMCUjoFcFrgb6IRL4AM36bV+uY4Iup8Z
         G93LTLk2ufgxCcTUD9z0v5zGmVcnjWdadJRz2kZXfjzOucDfUDXqMtkvcVnUdFvzIYVf
         6y0uLEu58B5L0bPq5h2AHa1eh9/HWMxNR2lo95Kilk73o1ZGeZBwZXn+zzNMMlDKNK0w
         3JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754649662; x=1755254462;
        h=subject:cc:autocrypt:to:content-language:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9DdjsBRQR9fIuAo8ImDGM1JqWF+CTi8v4E1obmb+Oo=;
        b=sp5kdH5fyR042Sp6EMRSdKZc0m7nkVyGLSd74a/FGOmb+WXosWfUkCyyBrrtTw3Naj
         5OUsPch7Y+kx+Q7JNlpDPhwbUFefOJN6gk6tOOtmttX6AkIXJCwxXTcozt+37OCLiLhH
         AwU31iXkDpaGIWmBRSxI9+7UxH3epi/M2dyDAm7w85FAdqeJOD+QqHGsZLOeGAWcm4PD
         RYo2sWCm2asp+/pL7GW3KuwWjhHKAFNLlbzrFWgBmhasUD11oyTM4BGPcVK1ya08+wkA
         lXEgOcDkM9ZvUNWdO4Z1DWBQlEXG0Hr+Q7TdkX0mI6v/uThsI/UqVBK50dLuNiyxCqN3
         SMvg==
X-Forwarded-Encrypted: i=1; AJvYcCVUCmTX/oiid/HfQOs08da6T3Ugmb/sJqqVO701Uh4EMf5EmAb8eQF84BC+EAPPFI8GCA1FpbhzQ6GC7x99fzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOl/MWSCWgb6AVfE11yLBZE60P+q/Uua9SNJ2KZGaUZPQMQ6lk
	cVgvC4MGr1QKBq7zO1XLIZWL8YQB1eYZByYF2xMluL6vx9kac2a7DsNz
X-Gm-Gg: ASbGncvIdEBNjGWOjQjdJMxwenaeksK94x6uSklMDKHVYaC3f59K4V64AePD5YgYlX9
	c0CxW/ZiseUGeDm7ZRnu7XyGXTr5dc/X5nEGth5jX4UXr/GF6QZMkSZawh0R/Fz0ina9kpw0T7o
	5sacEUYVVr1sD1nOMWnjpiwlgSeYj92oOihag0bkRFvi1jZgAL+oaPrIPu6khnSn/4bvLhzw+Pe
	S+vAllKhT2rifdAw0/7f7nQmLbaEW/RmlkaiGe0kqU72NU0rB/1ShBzM1NVmc5JwnxtodNbCyYj
	R7rwMIYzbWLTrmwcyJVZtjYwSuO19eEjAu7w68YsC9o9Od8d9G8DAbYSH9S5wYgh13VQbKaUZPF
	PYa5G0HpyNSj9NQaIjAc4kbsh/3vndA+2yGQRDqk=
X-Google-Smtp-Source: AGHT+IGoiepMO0+fSrZ70kusojQ1N+IbL8DRB6zumqX4g3VDalgN3hanPuVjN1iG0JVWXuqOpUf0sw==
X-Received: by 2002:a05:6000:4305:b0:3b7:888d:8d9a with SMTP id ffacd0b85a97d-3b900b72c86mr1976901f8f.29.1754649662091;
        Fri, 08 Aug 2025 03:41:02 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e587e154sm142540045e9.27.2025.08.08.03.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 03:41:01 -0700 (PDT)
Message-ID: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>
Date: Fri, 8 Aug 2025 11:40:23 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: selftests/futex: issue with -g option help text
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------00akhUlKXsw3K5odAYJLylBZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------00akhUlKXsw3K5odAYJLylBZ
Content-Type: multipart/mixed; boundary="------------mKpXt3ufdx0ueLLtxScDopY0";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <2e01e85c-a833-4725-8a62-156c737422eb@gmail.com>
Subject: selftests/futex: issue with -g option help text

--------------mKpXt3ufdx0ueLLtxScDopY0
Content-Type: multipart/mixed; boundary="------------9r2JN7nNJxnxXZk03AaTMQ1o"

--------------9r2JN7nNJxnxXZk03AaTMQ1o
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgZm91bmQgc29tZSB0ZXh0IHRoYXQgY29udGFpbnMgYSBzcGVsbGluZyBtaXN0
YWtlLCBob3dldmVyIEkgY2FuJ3QgDQpwYXJzZSB0aGUgbWVzc2FnZSBlaXRoZXIsIHNvIEkn
bSByZXBvcnRpbmcgdGhpcyBhcyBhIG1pbm9yIGlzc3VlIHRoYXQgDQpuZWVkcyBzb21lIGF0
dGVudGlvbi4NCg0KVGhlIGlzc3VlIGlzIGZvdW5kIGluIGNvbW1pdDoNCg0KY29tbWl0IGNk
YTk1ZmFlZjdiY2YyNmJhM2Y1NGMzY2RkY2U2NmQ1MDExNmQxNDYNCkF1dGhvcjogU2ViYXN0
aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KRGF0ZTogICBX
ZWQgQXByIDE2IDE4OjI5OjIwIDIwMjUgKzAyMDANCg0KICAgICBzZWxmdGVzdHMvZnV0ZXg6
IEFkZCBmdXRleF9wcml2X2hhc2gNCg0KDQpOYW1lbHk6DQoNCnN0YXRpYyB2b2lkIHVzYWdl
KGNoYXIgKnByb2cpDQp7DQogICAgICAgICBwcmludGYoIlVzYWdlOiAlc1xuIiwgcHJvZyk7
DQogICAgICAgICBwcmludGYoIiAgLWMgICAgVXNlIGNvbG9yXG4iKTsNCiAgICAgICAgIHBy
aW50ZigiICAtZyAgICBUZXN0IGdsb2JhbCBoYXNoIGluc3RlYWQgaW50ZWFkIGxvY2FsIGlt
bXV0YWJsZSANClxuIik7DQogICAgICAgICBwcmludGYoIiAgLWggICAgRGlzcGxheSB0aGlz
IGhlbHAgbWVzc2FnZVxuIik7DQogICAgICAgICBwcmludGYoIiAgLXYgTCAgVmVyYm9zaXR5
IGxldmVsOiAlZD1RVUlFVCAlZD1DUklUSUNBTCAlZD1JTkZPXG4iLA0KICAgICAgICAgICAg
ICAgIFZRVUlFVCwgVkNSSVRJQ0FMLCBWSU5GTyk7DQp9DQoNCg0KdGhlcmUgd29yZCAiaW50
ZWFkIiBmb3IgdGhlIC1nIG9wdGlvbiBzaG91bGQgYmUgcmVtb3ZlZCwgYnV0IEknbSBhbHNv
IA0KZmluZGluZyB0aGUgcmVzdWx0aW5nIHRleHQgaGFyZCB0byBwYXJzZSwgcGVyaGFwcyBp
dCBuZWVkcyB0byBiZSByZXBocmFzZWQ/DQoNCkNvbGluDQo=
--------------9r2JN7nNJxnxXZk03AaTMQ1o
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
bmdAaW50ZWwuY29tPsLBjgQTAQgAOBYhBHBi2qTwAbnGYWcAz2jCh9/GqAImBQJn
MiLBAhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEGjCh9/GqAImQ0oP/AqO
rA08X6XKBdfSCNnqPDdjtvfQhzsO+1FYnuQmyJcXu6h07OmAdwDmN720lUT/gXVn
w0st3/1DqQSepHx0xRLMF7vHcH1AgicSLnS/YMBhpoBLck582FlBcHbKpyJPH/7S
iM5BAso0SpLwLzQsBNWZxl8tK8oqdX0KjmpxhyDUYlNCrCvxaFKuFDi9PmHOKghb
vdH9Zuagi9lM54GMrT9IfKsVmstzmF2jiFaRpuZWxNbsbxzUSPjXoYP+HguZhuNV
BwndS/atKIr8hm6W+ruAyHfne892VXE1sZlJbGE3N8gdi03aMQ+TIx5VLJfttudC
t0eFc50eYrmJ1U41flK68L2D+lw5b9M1+jD82CaPwvC/jY45Qd3NWbX8klnPUDT+
0foYLeBnu3ugKhpOnr4EFOmYDRn2nghRlsXnCKPovZHPD/3/iKU5G+CicRLv5ted
Y19zU0jX0o7gRTA95uny3NBKt93J6VsYMI+5IUd/1v2Guhdoz++rde+qYeZB/NJf
4H/L9og019l/6W5lS2j2F5Q6W+m0nf8vmF/xLHCu3V5tjpYFIFc3GkTV1J3G6479
4azfYKMNKbw6g+wbp3ZL/7K+HmEtE85ZY1msDobly8lZOLUck/qXVcw2KaMJSV11
ewlc+PQZJfgzfJlZZQM/sS5YTQBj8CGvjB6z+h5hzsFNBE6TJCgBEADF+hz+c0qF
0R58DwiM8M/PopzFu5ietBpl0jUzglaKhMZKKW7lAr4pzeE4PgJ4ZwQd0dSkx63h
RqM963Fe35iXrreglpwZxgbbGluRJpoeoGWzuUpXE6Ze0A2nICFLk79aYHsFRwnK
yol9M0AyZHCvBXi1HAdj17iXerCYN/ZILD5SO0dDiQl570/1Rp3d1z0l16DuCnK+
X3I7GT8Z9B3WAr6KCRiP0Grvopjxwkj4Z191mP/auf1qpWPXEAPLVAvu5oM7dlTI
xX7dYa6fwlcm1uobZvmtXeDEuHJ3TkbFgRHrZwuh50GMLguG1QjhIPXlzE7/PBQs
zh5zGxPj8cR81txs6K/0GGRnIrPhCIlOoTU8L+BenxZF31uutdScHw1EAgB6AsRd
wdd8a9AR+XdhHGzQel8kGyBp4MA7508ih0L9+MBPuCrSsccjwV9+mfsTszrbZosI
hVpBaeHNrUMphwFe9HbGUwQeS6tOr+pybOtNUHeiJ5aU3Npo3eZkWVGePP2O4vr8
rjVQ1xZMIWA18xUaLTvVSarV7/IqjLb0uMTz6Ng7SceqjsgxO4J35pPOCG8gy85T
md5NKe46K1xGsNG2zzfXQ6cNkofUyQFGVbLCtdfQyWV7+dgUnOnPhrTKpFfJ5lnW
pLpze0LfyW03CpWx9x4yMlwcvIFw2hLaOQARAQABwsFfBBgBCAAJBQJOkyQoAhsM
AAoJEGjCh9/GqAImeJYP/jdppMeb7AZnLGVXd8rN7CLBtfMOkXCWaOUhjMRAY7dV
IMiF1iPZc6SgiiMSsdG7JJhMjMuLTxA0kX2Z6P0+6dZlO4bDOKMIv4nNGhgSj9Nu
SKJPRiyiXKKD/wNnPXVFdBZsoHnEXGyAFGnidu4KLUJIiSm4tHJdoMk0ZaJSmwt0
dtytuC1IWH8eIaVo/Ah6FxCaznRzvGNFx+9Ofcc7+aMZ15dkg9XagOuiDZ1/r6Vu
Ew9ovnkDT4H5BAsysxo/qykX4XQ2RQSY/P3td9WNLeXLvt1aJNRcwcIEKgZ5AO3Y
QbEJt1dEfCU7TAKiRpsjnC/iQiQHGt2IvNci8oZmM3EQEi7yZqD07A6dpGTnRq9O
Q7fGhj0SS99yZvooH3fBIHA2LRuvhfDAgTrpbU0wLvkAIo0T2b9SoRCV8FEpHvR2
b86NbTU5WN4eqZQbAbnxC7tJp6kLx2Zn2uQMvfXRfnS9R1jaetvpk3h7F+r/RAAh
+EvgsPUNaiRJRRLvf9bxTQZhmNrw79eIFNsRIktniLyomJf2+WPOUECzh1lfLqe9
yiuUKv+m5uAalXdayhiPbp/JHs1EDRgSq3tiirOsKrh/KMpwz/22qGMRBjFwYBhf
6ozgujmPlO5DVFtzfwOydzNlXTky7t4VU8yTGXZTJprIO+Gs72Q1e+XVIoKl3MIx
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------9r2JN7nNJxnxXZk03AaTMQ1o--

--------------mKpXt3ufdx0ueLLtxScDopY0--

--------------00akhUlKXsw3K5odAYJLylBZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmiV1BcFAwAAAAAACgkQaMKH38aoAiYj
JQ/+IbSu3zBWdQ412KZ21sqPlWi04amXJ5wZprK/akLmw3cdHr1+aBwLZTctKzhpSekhos/gxCpB
cBKrRayQwMcIe6gYH8hAY1uOWwCcTfT8aBzBGUfmueJ2WM6BmT0eGSQ8Vs7pa3S+5ENZgavevzR3
dkFkg29mgPPyeiEvHsDBWzLd8jHnNvzdO4KvNhvb5g7QR+bjVYmoBl+QGTVzckwPfb7vOa1rVwgg
Zbh4sX3HD6fWxuOgGlaKbfD3WCOD2fX3lZpjLHnbMK/avqDtIPLe/LG6TklDyFNRbGBe+U4rm9Lq
mFY794YL1NYOb4BdUUAoSkYFn++9P+yDKyofB3xN3+/qt17F0HD7hmw+mHLcDujCYfHTtbuDAepG
yDh5s/74MpQT+f1eLUDm1yyl7yOSi2QccXaoCqaGoRuo5Rgt493k+C1Atsm329cd29Og8nHeapeT
yHsj0E39Vyh/bD1bdv98caAFeo75nfqsLyQw9BKVH1m1GO1Wgv9olc+gci1wq2pddHE3sLfnT/7n
JcJ3Y6raJ0q127howp0dZvwmU3PzFpPaEto1cus8g+Q9GFzJ47TtsvdTQvJ+g0SRFtzxUvrnuoBV
fUBmhwDq2cMi4KJp9lzG/+KAcTdXTXf6RKXzygcNm1G/1TsN29OeMNY24ZNUuIRf+Ycyvt8+4Ml6
y4U=
=2Zur
-----END PGP SIGNATURE-----

--------------00akhUlKXsw3K5odAYJLylBZ--

