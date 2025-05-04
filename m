Return-Path: <linux-kselftest+bounces-32290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C61AA88FD
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 20:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F018965E4
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051BB19C540;
	Sun,  4 May 2025 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gugrFnhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA5EEC3;
	Sun,  4 May 2025 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383506; cv=none; b=ZZ5IK9jRG42j02pwyRGdHVdKYfDCwphrci+eNRqXeUHprxhcs4gZS0Ch8lIikAefVaNZDvFrWPrkyGbS2nyEezZhV29JpVSbcYZHVW38ShilqFO8qoDBv7V0898Pr2PDSsZYLlueTqJab935doF+KekFy/3b8JbvqXjPajcIcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383506; c=relaxed/simple;
	bh=jCzBsYxspV1laTgHvP+KP+6A7COw+U0qAa5tc30If1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y50oJUIlAUWrszdMPMd0eW4fOha5JSe2mOa6fbbgmf5llZB8DcYC6DJP97nyzIRgyvZ4wka6NgIdVsLrgv7TpkPVTMHKKG3Z7N9NFi+CHmC2tM503J6OAoWe3Xhiwms0arNk9Jew3ueNxYHkKeAB3gK1MiaL8b0mNG41/UJVXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gugrFnhO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso416623a91.1;
        Sun, 04 May 2025 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746383505; x=1746988305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCzBsYxspV1laTgHvP+KP+6A7COw+U0qAa5tc30If1Y=;
        b=gugrFnhOtP/wQCB7syn57/fbcg+OefyWoMaALxiwOVuaQDmBey1Z1nkXtW6V8HoaCh
         fGpoLzx+gySjvUhZY3umlaPmAGyU6wSo6WZNMo6LDk5NruZgeNjV/zY2a9bg1ETCTZZN
         ItK6yn40RmQpxN7M86z8naKrND06fk5E7/BfT9MuiIEBF+If6Cc6qA6vheKx7GYBx8CT
         yc1hbunhZEj7AZE997VK+Dj4pBh2ZuMiXLI19A3pLoD6eWHPvGTZPsrdp1bMp9f4nYHs
         3LpAHNhwRdvKvgGkprUqBiZuHjvGhcotDQFa0FaXOzfZ+9bEjro71XUz2VhDoDOA5fFK
         4+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746383505; x=1746988305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCzBsYxspV1laTgHvP+KP+6A7COw+U0qAa5tc30If1Y=;
        b=iMW1vCXD0b941zcxAOteqfw5uzVLlv8BATCrUj8GLWjeNWvhPoN4FWPSPGezlWTBTB
         /mVlvO6qVi14KhnSSpRzAkdzQVgtsBi4z5QMj0h34lgJ+x5A+T/2vd40p1W/cC7QReMw
         hCMA/1D4lhp532ZJZLK4houO3Xo8lgiYmB1b7P567S+D7MSEA3WgeBZmWYlMO9NGsd5g
         RUkVnGT364rrQ+H+mjgL0hZNFad60YptkneVEbJU+x/NWZsj0Xcy8QL3OwhazqbGI0Fc
         s5idQbuTtyppe1F0arDjsLZoVhP8YeQi4diR37tJTQQahWigoegsLMYwMiPNN16hpt8A
         4upw==
X-Forwarded-Encrypted: i=1; AJvYcCV4U/Gr59sExIZQlu73mzGfbV3201/kCcyZgBZonSOYK2P+l0T3iJ9hlzdmBftPMUiIzoIj7Cxx/hfCD15aK+i5@vger.kernel.org, AJvYcCVXM607rtOxqzQ0utwq6OW4bwjsvSLy9R2c9FaFCvCQw2yxaY/YYhNE/CKmwYDefQG8SqzuKXcuEFw64zqf5Q4=@vger.kernel.org, AJvYcCVep8RwskuornEXqLUg1jatcWhWpdITKl0KnO3+PJfqSAXq7nuAHm2PI4Lj1yPKYpfKaECTBfUcj49Kozs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdRJ5wqxNthjMtYeb5xLhG7qNE0cy+xyKv0/YYBciC4+PCPY5
	fJzIIzbaw20sukTdeTs+OrwOaHeankaA8mvw3+VDV1VND3jbRJKhD7wSjOb8M+x1pOnZeVb1AVd
	U+Ee5hPhFfC0M6qWFfKJOP+AYL/0=
X-Gm-Gg: ASbGnctgWy3YzvbjbgInEMkpy8xGzHXwnpApgF6AiBgBm6hY7exl++RDOhzNTPju3DG
	0fdA055ZWMVHfLEkH3tDzLFiJP8eyegVjOt6dgmb09KmpLsS7p+MeY+AMAvOopq03Vry8pGwtT7
	IfBXUp0Fz0ieIVbowtZLd5ZHQ8fmxotF3w
X-Google-Smtp-Source: AGHT+IHM1qFzExr2JO+eQkxetxwIHEXTTQylqRXZSO/+GOHj2EgGo9fWj+nqCH+Onwgpa00JM1zRryqBij0OZ8ZX1UE=
X-Received: by 2002:a17:90b:1a85:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30a4e578abfmr6303285a91.1.1746383504603; Sun, 04 May 2025
 11:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-5-ojeda@kernel.org>
 <CAJ-ks9k=uxxumgEU84-54u8OxxJVBsUprGk7Ht31ndoumHB95w@mail.gmail.com>
In-Reply-To: <CAJ-ks9k=uxxumgEU84-54u8OxxJVBsUprGk7Ht31ndoumHB95w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 4 May 2025 20:31:32 +0200
X-Gm-Features: ATxdqUF8ymJwZfZr1C5xgS3xxNqN2FX1ijfVb70q7bwMJYIUF0VTvVP0RvPxx3o
Message-ID: <CANiq72=Q_Vbfh6YhDsNeCBDPZ-q1d2HNfaTj4azAsd2Q-zPfEw@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 7:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Is that true? The build host is often easier to work with. There's a
> number of host tests on the C side that exist precisely for this
> reason.

Even for tests that could run in the host (pure functions), if you
test in the host, then you are not testing the actual kernel code, in
the sense of same compile flags, target, etc.

Moreover, you have UML, which gives you access to other APIs.

As for "easier to work with", I am not sure what you mean -- KUnit
does not really require anything special w.r.t. building the kernel
normally. In a way, these restricted host tests actually are an extra
hassle, in that you have to deal with yet another test environment and
special restrictions.

But which host tests are you referring to?

Thanks for reviewing!

Cheers,
Miguel

