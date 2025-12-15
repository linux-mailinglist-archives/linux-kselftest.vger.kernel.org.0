Return-Path: <linux-kselftest+bounces-47586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44384CBEDF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BFD1300180E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA28299927;
	Mon, 15 Dec 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gh98c3hT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9156D1A7
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815786; cv=none; b=XTBV7Hey8hwigkap7K3B0UY/gNP+dxB+ryTihoCom9jqfDkoij0fTXVym4B6PPBrNbB90YaZcZLrIyahcmAclQAibK1y18s3JxwXOp3Qa196CLqaxS7MVN3iZLXcAUonKHuDHCMQ0hi0LCg/MRHYOLnOgTIMdO/LZghfZQmeb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815786; c=relaxed/simple;
	bh=H6/qIsKA0Q8+RSdvirAXq3QxkZX+aBvWc+T3J8h/PsA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tsb7s9XJCD9736rQ/0kLBbsC9mxI2Sk4LzwvdeZd/XXE6TbziPv/fFo39BeUKYPm2R5mw1SkiS4vjIwcvOKYZEfXyx5YSF6mQc2XSQXyxlhoACn8bFxXfXs/v5St0oI0OdtpKbG/X+wHj+5KMyIeDdliaNZ5sg8Gag50Gq76XI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gh98c3hT; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 46C623F321
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765815775;
	bh=3Ir1CEZN9+upyalka7TDJAqojObkwvpx22aZn+Mk+O0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To;
	b=gh98c3hTm05jnaeB8PzX4JUZutGpEM6lZmPKWSVFrRbkCprGf3QdaISpkk/FoF7uh
	 aqPaxoqrpj0fqLspD0/TU81JKgKbZyYwiWebtGJMMrq3JPR/2vyVgaKMV8VqT0UtHz
	 645A9mILQOJ8Wly4/e7dNx0JDUuRvyrrbYtQfYg1QLMYxC0NWVXhRI4tE6hOJg6elY
	 PJHKfuZTIxJdIU9Q99FbRVxZlPBZ9mTwH9+O1k5T5TLoAFCq4Av5QbjgKZbfkd4guw
	 /zxn+bvsXYNJX5/WX/8OpgVEOcQbQO6FSmMUbh1Eb/x4hONOSKcFH4wlrDwrvS/sSk
	 OV4b2tGGuEdAQc6wgr8RFfbN4oJebDPXwQr0BuRR5jS9rHGjvLQs+p7YWZ0r9PRlq2
	 2+iRjjAnxK9fGSCOzlXcSPlkEwguYW7Nsh93m3NxIZ0h3E/Rr11wpa6YdDbkXMuUwc
	 4pbieiAun1q2AMm34fzwWX3z6Vow3RVtM7+QHTPics1FiA+kdDWjN41HyyvgYmBVfh
	 luA6NS9O8pLZi56UarPx5QwBHkP2oYn/PUqoUDTZx2maAIjw//TdFfEvtiQrRY264r
	 48MFvgEACRtTTwZxOTqZMbFJ9aPQJAiR43XrjHV13wTYhwpi0j0OJZ0R9gJI1nRf+2
	 gExuIRImE19tfx9jrhhEYEXI=
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a3d3823e1so12392896d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 08:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815774; x=1766420574;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ir1CEZN9+upyalka7TDJAqojObkwvpx22aZn+Mk+O0=;
        b=lcpY5bOAFMKzWgOU0Jcu+KDnRm1ZNedUkiIlzZJx1YJpo8t57jU7+7TeBAWKMD4v8R
         Cs1bNo6vEjVnnNIcyX4pHXcRFj2Jc7m49LLiJsqHFbbrXEYoNiUdYNtxdhljyT5SIz5y
         rpatwVFy7Jv8yPrgc7nwfLrcgG+JJeh/UyPZwRTj+DMzQ25ZIZsv6S96iXqldjjD/omt
         ujsZNVsK9y2n5PQJU6hajUuY+qySotvG7mLjgSAH68DQ7MWScXRXWbbtuTsHaADuB/Ha
         xPRubCXLUrgd9rrDbKq/E2aheaHgtnmyyGERdwdP9xEOec+bNYuDRscrxnZCyywRKC2u
         Elww==
X-Gm-Message-State: AOJu0YxChuZv2+TMspzG9uPZcsNR95WS+zjPd+H4sUrj4xklPYIOxF/6
	L5nfubwX1QP9uPYjwhhTjIUGtWr1lM/Pe8W742q5IsYrqQD/0jfC+e4K3tDO5Sfi8pHAkHU1hWN
	m5mov65sbz85WFxywXYDamA2B28ksuGZTRf5AyVX9ZT30DpQ/gk5dywYqEV6ZZYMKjnFJfnES8v
	8v+Vvc/4Cl7A==
X-Gm-Gg: AY/fxX6iRrw7d1o1UgkTF9reDwGyCPuYNzHm2XLohJKRd9Udbhr6G4KA4F0uKcaI0xY
	XvFy5pFQC0gDKRhXQqfJP8IHwValxwDgKymVsAc9ADyN8qMiOzkGLaHx2rxo7lcVEdm6z9ejwjh
	OZHnY6HGqdu+LHxy0xjMbB7x3NbuWgzIrBDncc/bOiKOQcF8SzkjEbiANgmqUvaF6HjD4gFqPiP
	KjAKSRaawjxDMoqDQGIB+70djbU1s7Iu0MNoPvo101RGV9M7hVK7/76/y7sImh4kwbvY/JqRcNi
	zglCr8V+QwRH3NrqiiEyPubEHKiu+DuqMGYw2q8mfO6j0lj2EpN6kazfL5SmS26EFbqiDxcz6PY
	LBdBN7TnA5fP3TTYq0Lii1JSlCOd5hnqod/7et/GAf+nz+ScdHPVJ+6/AoYJj0NkD
X-Received: by 2002:a05:6214:1946:b0:882:7571:c023 with SMTP id 6a1803df08f44-8887e4486cfmr185071006d6.47.1765815773911;
        Mon, 15 Dec 2025 08:22:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5MW4WueFKjbk2y4otlZjYZfwclwOXkENHDfzGrX6nOXeTQEArHONWVHMQkULecc9Bem2ktw==
X-Received: by 2002:a05:6214:1946:b0:882:7571:c023 with SMTP id 6a1803df08f44-8887e4486cfmr185070456d6.47.1765815773466;
        Mon, 15 Dec 2025 08:22:53 -0800 (PST)
Received: from localhost (modemcable137.35-177-173.mc.videotron.ca. [173.177.35.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5451da7sm1111449985a.8.2025.12.15.08.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 11:22:52 -0500
Message-Id: <DEYXG6ZXHLE0.39WQE3DELH3QQ@canonical.com>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 <netdev@vger.kernel.org>
Cc: <linux-kselftest@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Willem de
 Bruijn" <willemb@google.com>
Subject: Re: [PATCH net v2] selftests: net: fix "buffer overflow detected"
 for tap.c
From: "Alice C. Munduruca" <alice.munduruca@canonical.com>
X-Mailer: aerc 0.20.0
References: <20251212144921.16915-1-alice.munduruca@canonical.com>
 <willemdebruijn.kernel.1702e18dd0a@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1702e18dd0a@gmail.com>

On Fri Dec 12, 2025 at 2:18 PM EST, Willem de Bruijn wrote:
> Alice C. Munduruca wrote:
>> When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3D3', the
>> strcpy() in rtattr_add_strsz() is replaced with a checked version which
>> causes the test to consistently fail when compiled with toolchains for
>> which this option is enabled by default. >>=20
>>  TAP version 13
>>  1..3
>>  # Starting 3 tests from 1 test cases.
>>  #  RUN           tap.test_packet_valid_udp_gso ...
>>  *** buffer overflow detected ***: terminated
>>  # test_packet_valid_udp_gso: Test terminated by assertion
>>  #          FAIL  tap.test_packet_valid_udp_gso
>>  not ok 1 tap.test_packet_valid_udp_gso
>>  #  RUN           tap.test_packet_valid_udp_csum ...
>>  *** buffer overflow detected ***: terminated
>>  # test_packet_valid_udp_csum: Test terminated by assertion
>>  #          FAIL  tap.test_packet_valid_udp_csum
>>  not ok 2 tap.test_packet_valid_udp_csum
>>  #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
>>  *** buffer overflow detected ***: terminated
>>  # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
>>  #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
>>  not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
>>  # FAILED: 0 / 3 tests passed.
>>  # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0
>>=20
>> A buffer overflow is detected by the fortified glibc __strcpy_chk()
>> since the __builtin_object_size() of `RTA_DATA(rta)` is incorrectly
>> reported as 1, even though there is ample space in its bounding buffer
>> `req`.
>>=20
>> Using the unchecked function memcpy() here instead allows us to match
>> the way rtattr_add_str() is written while avoiding the spurious test
>> failure.
>>=20
>> Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
>> Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
>> ---
>>  tools/testing/selftests/net/tap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests=
/net/tap.c
>> index 247c3b3ac1c9..dd961b629295 100644
>> --- a/tools/testing/selftests/net/tap.c
>> +++ b/tools/testing/selftests/net/tap.c
>> @@ -67,7 +67,7 @@ static struct rtattr *rtattr_add_strsz(struct nlmsghdr=
 *nh, unsigned short type,
>>  {
>>  	struct rtattr *rta =3D rtattr_add(nh, type, strlen(s) + 1);
>> =20
>> -	strcpy(RTA_DATA(rta), s);
>> +	memcpy(RTA_DATA(rta), s, strlen(s) + 1);
>
> Could call strlen(s) only once in the function.
>
> Why does rtattr_add_str do the same without the terminating '\0'?
> It is only used with IFNAME so assumes max size of IFNAMSIZ perhaps?

I'm not sure why that was the case previously, although this
hypothesis seems reasonable. I'll go ahead and fold both of the
rtattr_add_str{,sz}() functions into a single one which includes
the null-termination, as that seems to be the correct behaviour in
this instance. (while addressing the strlen comment above)

I'll also leave some time for comments on the above before
submitting the changes in a v3 tomorrow.

>>  	return rta;
>>  }
>> =20
>> --=20
>> 2.48.1
>>=20

Thanks for the review,
 - Alice C. Munduruca

