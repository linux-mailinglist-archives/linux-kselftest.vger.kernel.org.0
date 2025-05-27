Return-Path: <linux-kselftest+bounces-33830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C749FAC45A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 02:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80561178EF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B11862;
	Tue, 27 May 2025 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFDfwGwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA910E3;
	Tue, 27 May 2025 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748304668; cv=none; b=MLYWKFGyGhEQ2SvXE3gvYmZYRVQPO9gQiB5jDMmlkj+/Aj9ha005Quw4XwHBfdgsKtkd/iu74PzXYbVJaQHplOZjTfJ46y3Vg/UPhYdhttxAyTYs0YtbS6o+3N6Kzz3VCA1KHWryPjiFBNc4kpyIjHCXizH+9qPizbiLsC3gHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748304668; c=relaxed/simple;
	bh=tw+V54TzTF5aeL1GSdSVDzkRh6+ofawdotvvYMClxDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRS1QgTAH+dlWe2wClmFIxwXLaq4M0EZ0vvd+lYyqqon8RoLe3f4OmJQ4CElHnhN7Doiv+tntNEsAcLqkrK9hDvet0g6BMzrjfnCqh2gVBoZ98iHzlGrvx4H1Xdm4G0PJ/osQk1JQRUKz+555456fkZGxlIRvmorbahDTVSkajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFDfwGwX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3087a70557bso489655a91.2;
        Mon, 26 May 2025 17:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748304667; x=1748909467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtTCmrZoRrQ0JqD2tIFY3u/ae0Uri9xjv3XvvvkKWb0=;
        b=ZFDfwGwXW4DVTmYr32UKAO1J+FUBnc+0GO4XVr/91ZmfT2M7Uu+dgJkhBFISoDEjA4
         kM0JXKOKBrRmpkx9JpFEyk04GEa2CKQK8eqRTxNGTOpvjKut1+SClMopg3rkhJs3rPuC
         whj8Lf1ut2DcleqKNxhvN+WAFnhcR58ZjSkomfivAk3lMI2mgKoQuGu8MV5Osz3lM8x3
         ehJqg7wSdwfYdyj4mefYfOobYhTPrw1A+AEjWeYsdXUHAwW6Ya05dfFD7K9fEe97aD6k
         GmlY42RW7cd0jksNeXFGX4TOPYriktJETUlZl/SNJfKvg39xKpcdWhgul9yCZYGmOXiF
         gxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748304667; x=1748909467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtTCmrZoRrQ0JqD2tIFY3u/ae0Uri9xjv3XvvvkKWb0=;
        b=MA0Z4CPLW7WQZn6Du++eLZk1d0rgqYM1y2aYdQxi5gNvjiKpi+AnQ5TkmhWmEwkOq1
         amow2MzSD5mE5NjgEHHa79wX9QiUcUUjBmcCMefRK5xK47absPO/MVlS2tlE5oWEv+TB
         aaZIkBOITh9HGHkYf3mj1GKXn/kz8x6TXOPLwfCNI1RXakaMDfLi+Oq29K5UzZBa+pWd
         AXDWpTlCzicPO+CjSn5UaGER21spMQru2qENCQi/Uwjpa1SWJBRiDnTrx0o/M26fSVVO
         uuxZ5qZ8AhOHVQEsoUsMmSv/nPJhANTQ1kvOgSfM45Z8dv/q3LnSC3q6jC1v7eFVlWDc
         zStA==
X-Forwarded-Encrypted: i=1; AJvYcCVP7v73iGyk7cqnUc+qD54ASao2hQwwnSWBFJEGMlorTrSDcqYus0UaNXLcpJV7mpuLvmbcpkvoDm6/dJ0=@vger.kernel.org, AJvYcCWPCfQNVeUQsjzvUuAMn7STNAn6++h9SSxVsv50UsNEfM6E/K/RjfyQfMqYxHT2Ea9EjfVE/jnYBH+SwEBDC9g=@vger.kernel.org, AJvYcCXDQcArumpmiwt1ct4ORNt8SvWTO/fZm1SrtTEQjDXnXyWJetS/HCYMR1xLPEEFBeZRgRq/2qS5dyEf6VRIblNf@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNJrMUrEUFJbjvEQw2m917qQyvc2F3bIMmKO2kQ+II60p6fdF
	L1ymNq+cACt1/mlF5v3KDRRyDqFnmjVJA4AiTkPPwhsgB894GM7FgbrYjelrfS4HYO3oaDTNr2f
	H6UsyMpJk58OKEkjVqcbg1rcAJuB3vk4=
X-Gm-Gg: ASbGncs+LGAqodiU8XCo3OCQXAw1YWKe7gajTMjorIXVoUh3GLv2jku0cWPJhn5d1lp
	3dOtOx7/5YESyLv4FnOhdOVViZIK/8A7lx4hXOR4d0L3nj505fw3eY5u0L9wQzcfOLAgQc3dZXo
	EQdbTgbYcLj3Ji7lOducRwLNIQURyUDYxH
X-Google-Smtp-Source: AGHT+IHuJYZe8bONowCh96S26GJWzJMXTf8gJ+iXWDqS0aq8KaIuLAGuRkVGgNILqDbnpOeuvHai1AtCg5SRH+0v1qs=
X-Received: by 2002:a17:90b:17cb:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-3110f72c97emr6529967a91.3.1748304666678; Mon, 26 May 2025
 17:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 02:10:53 +0200
X-Gm-Features: AX0GCFs4jjYfVU6bcAWIwvQqEUw3eEVTRURfBNgMbKp-7WpJO6lmgJTaph6upiw
Message-ID: <CANiq72mj2yv4E7Dd+19fmP9xGWELdv6JwXULpu91oq0BMzob+g@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rust KUnit `#[test]` support improvements
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:51=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Improvements that build on top of the very basic `#[test]` support merged=
 in
> v6.15.
>
> They are fairly minimal changes, but they allow us to map `assert*!`s bac=
k to
> KUnit, plus to add support for test functions that return `Result`s.
>
> In essence, they get our `#[test]`s essentially on par with the documenta=
tion
> tests.
>
> I also took the chance to convert some host `#[test]`s we had to KUnit in=
 order
> to showcase the feature.
>
> Finally, I added documentation that was lacking from the original submiss=
ion.
>
> I hope this helps.

Applied to `rust-next` -- thanks everyone!

    [ Used the `cfg_attr` from the TODO comment and clarified its comment
      now that the stabilization is in beta and thus quite likely stable
      in Rust 1.88.0. Simplified the `new_body` code by introducing a new
      variable. Added `#[allow(clippy::incompatible_msrv)]`. - Miguel ]

    [ Used `::kernel` for paths. - Miguel ]

    [ Split from the next commit as suggested by Tamir. - Miguel ]

    [ Split the `CString` simplification into a new commit. - Miguel ]

Cheers,
Miguel

