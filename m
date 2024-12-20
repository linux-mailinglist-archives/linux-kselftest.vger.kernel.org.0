Return-Path: <linux-kselftest+bounces-23629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382F9F88CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5796716F2C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB180EC4;
	Fri, 20 Dec 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnjoD8rp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F44430;
	Fri, 20 Dec 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734653088; cv=none; b=RtW1IGmczE4IZv7784sGC7mcC+r+DQRFVx9F6G9cRp9SXoyKbSQV7HEkpxg/Rn+F1jSXAHKomvfgjoD5aBDt/fMwS/Z3Eye/Hu0aZhpGBa2U/ZVFQFNn7utc12FzvxLseCPAEGRk8LY9UTGl6uhQXYTCtUkQpea9DZQM0wo6/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734653088; c=relaxed/simple;
	bh=ANrtncHo1LQh/35fTDtHJD5Xd2dfDSJs3cHDwSzS9zk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8ic8ByqMJHUdRlpWA5Q+AbiPb1WZvKkBS3Rg1ZYI1jK9tCjfmPbDkbpW7vL18ZR6/F3lCmmnLdm89v6zw3sf8PEzUuWSqUYFOgT97DEIor2HgoGK7NUqBtMPjutMkJPusalQYcmu8O7J5R9nAhTt98pn31DHB0DK6mMm1GFXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnjoD8rp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso18043815ad.2;
        Thu, 19 Dec 2024 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734653086; x=1735257886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8CepycYxL28B04HmL1mPwK+B9B80yTS6FANimaMQbIc=;
        b=HnjoD8rp55TYjCa0mEZKY2biSVSe9HdRgerM2927NYY3VF3Ml3QVe0pQ1MQIckFME4
         nCCju0eESaE60atM38eF6zF5KHdd257s3F3jWp7KVavFKORrb4ppP1q3VGRg5OanzSjh
         tjZKoj8Aod4gJnezCilE3hbEvWcTuvErd+ZU9UkUKfC4fwvekeAeTe34nL0B5QnMJ4BW
         gxhpoGHhNU7ykZvjCJKhss5/nUsoThl7+SMfLAcZ9vpSlqUxpxnaUxlOWDZFZSbVAsh4
         skE69uh5qiPWJYVf+aY40sWsFhl/QvIhjdwhhg/WBLpnAtengb6V4tGd2Xqe6tKaR4Lb
         Ox+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734653086; x=1735257886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CepycYxL28B04HmL1mPwK+B9B80yTS6FANimaMQbIc=;
        b=D/HC/1wVVaJuHU3ASgcaWg2pSYSV4gehCil0mAEdoe5W4lUWIOEgbZO4TmeiHCf5AC
         IZLz0yEoZvECIam+HIxDMFpoj/Lo5RrwwcQ/xNWb9huDTBJqmVw+lMKYChb0Epsyx4lq
         ekgHrGLNKnRQrkpyUlcsWIAgMdik9WjWpn7nj2Q6ar9U2NnES7wxGGw5ZEnOR02s/iWG
         vpvoe7yRrMOyIHIUImeQ++daHtc3UH7dd3+XgqcQv0ju+uDpJhf6rCWh4av/wbLF3ef3
         ACtm/QhkONp7QKGMy0H0Bd1f+0meMCWoOEWjHKdCaSHQJZOYE+NvIeDG7qTGOHFMr36s
         MjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2r5OkCYCsQy3khh10f+0y+mjikTf1FhbE2LL6Kr9F32+j3ZpVixqecRu0cxAByLQyFZaj6xiVJ3PmUHhD/X4k@vger.kernel.org, AJvYcCX5z6kTJ0/2LQUm177EptR0bxh+o1NXG2cbw82X6cDMjUwjsSuJeGDS5Pnw7RtaqfowLiI=@vger.kernel.org, AJvYcCXwObR6M589va5Rb4Rvg1zyki0crzqvGUg1BpWGpRBOiWuY4fRdGTeGSWExvxW0LPZTFW6yTqx0TDddTYW+@vger.kernel.org, AJvYcCXwX6DlDF84JU+b4J8S8CwaO912d1uH7pfdZrEHmO7ATVrsfwzJNkJzQEXJMzWu68S2W9DBo/T2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2oN099MdS0nBfmpTchqflYkck+9H3SvoLNXovS6U0CVPuvWC
	hNbv0phEE+1omIla8XoX25roIMB+mdmOsxMqBmsHvXpt8qDNjUvH2Y0hUiIX0wo=
X-Gm-Gg: ASbGncuHYJBEbFLcwGSVDxsLtLv6EeIjjLFvEt/fudWm8+QZbJ6grwRuCmOM9NbAVwM
	NJN7LGqB+QhiLh1KNopqgzxtWaTSwbM5jVaZQyW5FZ5yNIOgG20jH3wkSO1U/s9w6sD9zV20yfc
	5vJZeeekpNH/LIO/7iXFcfCVwJV+FSJ1WN5QX7fvMbEMZRJv6GOsZ/uMWPL7nCSSev9faBwRNnP
	mCSfJamWaRoBiiwsi3VzHa33y8J51QHrfQ15Ti8jbG5exG/X1UXbc/pdykA554qEJsie39ZxVrr
	73zqHuE=
X-Google-Smtp-Source: AGHT+IEa91rQ3bLAoWCP7bDL2vYjgeFKcb/ugKDPqLNMvg/RpNsaGfVLVTL4JGYYfofP+JedO+A/sA==
X-Received: by 2002:a17:903:181:b0:216:66d2:f172 with SMTP id d9443c01a7336-219e6f4a86bmr7525045ad.56.1734653086431;
        Thu, 19 Dec 2024 16:04:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:6d82:facf:302d:61b7? ([2620:10d:c090:600::1:12c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962db4sm18109885ad.7.2024.12.19.16.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 16:04:45 -0800 (PST)
Message-ID: <a2999d8b4827516fe4bfd17646d2284580712d08.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net,  john.fastabend@gmail.com, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  netdev@vger.kernel.org
Date: Thu, 19 Dec 2024 16:04:43 -0800
In-Reply-To: <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
	 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
	 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
	 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
	 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
	 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
	 <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-19 at 14:41 -0700, Daniel Xu wrote:

[...]

> > > I think that if test operates on a key like:
> > >=20
> > >       valid key 15
> > >              v
> > >       0000000f   <-- written to stack as a single u64 value
> > >       ^^^^^^^
> > >     stack zero marks
> > >=20
> > > and is executed (e.g. using __retval annotation),
> > > then CI passing for s390 should be enough.
> >=20
> > +1, something like that where for big-endian it will be all zero while
> > for little endian it would be 0xf (and then make sure that the test
> > should *fail* by making sure that 0xf is not a valid index, so NULL
> > check is necessary)
>=20
> How would it work for LE to be 0xF but BE to be 0x0?
>=20
> The prog passes a pointer to the beginning of the u32 to
> bpf_map_lookup_elem(). The kernel does a 4 byte read starting from that
> address. On both BE and LE all 4 bytes will be interpreted. So set bits
> cannot just go away.
>=20
> Am I missing something?

Ok, thinking a bit more, the best test I can come up with is:

  u8 vals[8];
  vals[0] =3D 0;
  ...
  vals[6] =3D 0;
  vals[7] =3D 0xf;
  p =3D bpf_map_lookup_elem(... vals ...);
  *p =3D 42;

For LE vals as u32 should be 0x0f;
For BE vals as u32 should be 0xf000_0000.
Hence, it is not safe to remove null check for this program.
What would verifier think about the value of such key?
As far as I understand, there would be stack zero for for vals[0-6]
and u8 stack spill for vals[7].
You were going to add a check for the spill size, which should help here.
So, a negative test like above that checks that verifier complains
that 'p' should be checked for nullness first?

If anyone has better test in mind, please speak-up.

[...]

