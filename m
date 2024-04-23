Return-Path: <linux-kselftest+bounces-8658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA78ADB36
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 02:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DDC283F88
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4467B3FF4;
	Tue, 23 Apr 2024 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxGac3A9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9F14F98;
	Tue, 23 Apr 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833023; cv=none; b=ozQ+1ozc7pJKq6q7tRE7Vd/DY3c1Jb1F0J+qbnpbt060BkhkUEmaRH6+vbf+mTwh1iFB0NyVb0/ogUSuZr+Zi4O7oJcjm0QphgVS/kKSLNPfmpijPNVUW5+0Nmx3RQB0SmW3YlQ3HOHSjsYMFRvLUiFQ7R8cp+oWs0Lnlstbdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833023; c=relaxed/simple;
	bh=b69z8MKu5WCo7Cd2DA4gTZQA8lpYkKyRqYcx1dxF34w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syJVGsCNYg9S9VBSFiD1wylnR/mKawTXNlI3Cc0lFxsCjTvkhDrBUfNTJSv0iszcc3vQT8bKwF35cwSaSfUniLJggPkTvSbqFm/B3krZv/IlFNz9jNvtHw9DFE1wwL5BeQDwNvVvEmg5Y1KaLbnewxLRkSJ4zYms1HoIIEVo/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxGac3A9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso3992371b3a.1;
        Mon, 22 Apr 2024 17:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713833020; x=1714437820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84vJQPmZeH4flu8huGOV5q9Ft8py+u51GWOsQbHslr0=;
        b=KxGac3A9r0gl3ptsFB0rbrAVkxelN/Bcj5qFPEv10E7SAkPs1ZNvfK4qSYOgsqVC/c
         gVgcFkm27qTIijIwNxAoqgzpYu5u7bmtnTQpSaDPYlmyfLA/QnallktYE5mllmXKSOA8
         al8THU2STO8Sp3GJqxwIdxV5ag13r5Sh2vNvNNn0XsZo4vT/0aKWV8sjn1kzKN6aUnoG
         Wf0Vuz/jFJMO9FfzU9E/RGXrsfT8aUUYsE3VRxImNKSPPzwMqlz2o8cjwDZd4BYhR/dr
         Zhr5hkCjTAxqxOakslwTG0UskTgwbB/Whe66I4klBicr7zIUSErWvZ1ma9qJxY1EprBP
         +dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713833020; x=1714437820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84vJQPmZeH4flu8huGOV5q9Ft8py+u51GWOsQbHslr0=;
        b=EUwWvHgCHsTQEYZazTR/9rEdWlxy21MWbcLHZpn9u/C2Ep8DzbBeBKO1ecU9J+lF8M
         KVavfyfCgYQW4FUrgtQXELULaTpmIX5tkoJyIS2CauWfy6Fom85/F9ktl6OtYhJ0BV6b
         WUx6Jf6A+s01sSfG/s5lSid61HeRfuHfZ8HLP2PE+SZ2kuS80MvZ8LUV/ovsZ/LpDe3t
         ZksRLsFjl2yU4JjON/IKm2CzeIo5ig2ZYaes0Jysk2CGXqYdQyrqMFQUG+T8WdSmIngP
         8Jd9ER8eFU5EIUcaVwS/px38jncKXa9vj8Up4FV1KVYaV16y0uwSCb+sxHUQSYunasC2
         8TfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkLz8ZjyWJhaFWC18JGuFGvPQLz1PnEbNJjf74il115kcALG00ut4vpw6hjWi4CEqccJ1D/PkBwZONf7reI/wpzgHv3cSiRkHr2zrcKMTvTqKUybgcuxtoYehXBPLeERK81ojtVACdCmSIQLmKuj2cOV/F+CuJidT8WWK+I//rTcGXbt4C5adHWqsfxu4HJIYmETWnkSSGNBGBv7KEgFLLpUChIRnm4xr/JLSah1lLyyupeeeL1ibCuYNHLH/3/kx/Byk=
X-Gm-Message-State: AOJu0YwrACmE/i/ujLkEQX0z4WEr1/peJAPygfy08+m1PrcO7kf3+sZF
	IRqnQgMtf8koMiJb0kjaRte+rPlELjYkKaY9Nj2gCd1rf9/UR2wkWUA8W69JXm3vGTnHxLKht7O
	Dg9ZeFT0lFWODY4cJFqPh7EBFgzI=
X-Google-Smtp-Source: AGHT+IGxeORm1TBskNYFb9Q9UnxlPWh+xAzteXrnLfX4ZhQxPREhBxwkngicmnabL/j5mMF9OrXzpySLTVciO2cdmAw=
X-Received: by 2002:a05:6a20:9f43:b0:1a7:6a90:8820 with SMTP id
 ml3-20020a056a209f4300b001a76a908820mr13612612pzb.4.1713833019802; Mon, 22
 Apr 2024 17:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422091215.526688-1-ojeda@kernel.org>
In-Reply-To: <20240422091215.526688-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Apr 2024 02:42:34 +0200
Message-ID: <CANiq72=xkmSGNCiJOr5+YZhKUVYjMwfBZJVCXbDfdf7qEGBAag@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Gow <davidgow@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:13=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> When KUnit tests are enabled, under very big kernel configurations
> (e.g. `allyesconfig`), we can trigger a `rustdoc` ICE [1]:
>
>       RUSTDOC TK rust/kernel/lib.rs
>     error: the compiler unexpectedly panicked. this is a bug.
>
> The reason is that this build step has a duplicated `@rustc_cfg` argument=
,
> which contains the kernel configuration, and thus a lot of arguments. The
> factor 2 happens to be enough to reach the ICE.
>
> Thus remove the unneeded `@rustc_cfg`. By doing so, we clean up the
> command and workaround the ICE.
>
> The ICE has been fixed in the upcoming Rust 1.79 [2].
>
> Cc: stable@vger.kernel.org
> Fixes: a66d733da801 ("rust: support running Rust documentation tests as K=
Unit ones")
> Link: https://github.com/rust-lang/rust/issues/122722 [1]
> Link: https://github.com/rust-lang/rust/pull/122840 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` early to start getting some testing in -next.
Please feel free to send tags for this one.

Cheers,
Miguel

