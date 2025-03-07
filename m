Return-Path: <linux-kselftest+bounces-28505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D33A56EB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885321657BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303B23F28D;
	Fri,  7 Mar 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlQBeuFJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5623F27B;
	Fri,  7 Mar 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367286; cv=none; b=VvuPjPXKWD/QITdad6jV7WSpYW8f+OgCfN04horXg5iGU/9ZJFANXc9TN57CC47hIqPJSn3mqj8JRK1NgspMxbDIMpRtWAxMgt9MzGAQjbIh4rbEaez1Mbc137A+4G4aPW8/kxbWwU8wbvx0lHbKsxL1Bb3FfuZUlcvS2Txo5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367286; c=relaxed/simple;
	bh=ktD0lf4VCt8loLbqFUJC6GSfTQihnec3zJXK/iURr6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak6ZMnUSsF9+syvtrpg0OeOIhJlfzAnZ74bksKzMc0Kxu0L4QwmE9pE8N/VasAzGuT6VKhQuogrXYmBnxwTq7i5tUmQwIOG7VEL22K7CF3T0OmGfBFjly6Hy/CvQCNeE1fxRw5zdkzy0tXx33dskNZpsbt40z/DeHLrCTlf7lA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlQBeuFJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfca745c7so3254461fa.0;
        Fri, 07 Mar 2025 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741367283; x=1741972083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2z35a1t91F/ztrHrZrqBq5HOZTDmQp+qlaW/KuybsE=;
        b=AlQBeuFJeHzHlm0opl7lNanah59ugI8if0q9wr3WFthhH9c11ElC/WJVifhFSe+72D
         E9y627jsLnQ+n9NRCS3HGev8/sPDhCIltawnuM4XQF8wdauh/oRRp/SZz623shIP4qmF
         F5UrbvDVm/eJUFJlG6pEy2QsVhpWydXkCxqr/NCt//Wst3XBqbBHNGFKB12+tsgL/1m7
         XlA7WUJ418zLRR3NxgMLOLhTmq6WKnrEN/GZe6owJuMqnyf5tDHlFlIs45NmT0moPua5
         qJN69yz9c1ZqQtJKjkMJRjps+hgRr4geOrpNYfRObJnIIzgqpe+QUR+nMppIAhadopPa
         tmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367283; x=1741972083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2z35a1t91F/ztrHrZrqBq5HOZTDmQp+qlaW/KuybsE=;
        b=vvSj1IVmjDCf8lNlZhOITwdjVuXq4EZMuJ1krC0cUQu80oNlho7l4YDda95gScyU0K
         rEZ86UClU4X1POyUr4aZl3Zc/mxHzi1c2GGVvWPK5WGfgXmCgmfARoBxTDerfX009WkC
         31h2/rL2L8yrYxPZ1Fog0sseDicV+SeHizIzKv7oEchu+xePk3ia7JnDpaGzgDPBWTHn
         UAJ4CAD4AULeScKKy+3k1T0bwyS0lvQvV1ib24Tl75W6BdyRItbTLR2kqClKeLNB8xvW
         JfquR5H5+z71btBMwynz1D6IJYLhvgIUeNV5anhvZ8dp4HLLvDb0spoIl7E7y3dRjnTh
         Pjdg==
X-Forwarded-Encrypted: i=1; AJvYcCU+IAqwCmRRkCneEak7mHOCU2+ElAPYV01bhM/HxqIJvZj36g8RDTq3gCOtNM1E0Wmm928OQCYHqnw7/zzVOLY=@vger.kernel.org, AJvYcCUQmMH4A8X3a3Z9hkq2Nzf8H0/g4Oz5Pu3v5QL+gOfzNAu4cRt74zsDagmOjpbhVdCqsWPp99Xwdz3q7lLJ@vger.kernel.org, AJvYcCW7rLMkXrE5iHNzGrNx1uTXCGJrjIdCnAjL4ZYZTdzkRVMMcsJRB7aCC0HwL9H3gj4R1fwSUy9ODqYko25lGmnA@vger.kernel.org, AJvYcCX1qSDyQsm9LJvthzvLLUzXUZc+NJFBAdQc/o2nfFUvNjc/iV7GGuWhKWZ0EyYsO1W0xg9807r7wjIa@vger.kernel.org, AJvYcCXOEFWAhmoPJwstr5WEdoklTIysbCOnqSfIveI2ZK+f0oQbd3L0NCKNqjFPqOImIMVBtRdI3TsJ5HIzRRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAIKcH3zBK8XdVnyDU3eFm1fqIBl4QD8XwrkCVWqpvi/nmHMa
	IqMHztd+YawhstQM+YRIBLkmLq8NBS7iMW0mTnIAq+x+DBNMAgsV6LsNA3NfxOBFnMWsMaVae8I
	USyoypDrHav4+GYpvnw/Na1Oi5Zo=
X-Gm-Gg: ASbGncsNhpX1rBf81ehgtRZ7G3axYu1Rku2iLP4jRN9ckG6pZL7jVcoubRFNnruUu2N
	xQGbuOHh/oyxTcy94Mcz+Q16BIlCMrj7sPnOHorwkesY14CRs/NP6Y8moRwR3CwPNQJ1VlfWFwL
	forsPQWZL0uVIrpt63MYsSJYutWKNpQjZnT2ZsqrPQU9Sy489t1N8tyjaQaso=
X-Google-Smtp-Source: AGHT+IEq1zBlCLTvD9Joq/2N4uxjKzwl7s93oMz25ye2VpU7/QOtZYqRLJEKrwIecdcUaIFqV+9Xr/d9AjKundnQBhY=
X-Received: by 2002:a05:651c:410a:b0:30b:addf:70b8 with SMTP id
 38308e7fff4ca-30bf4633e92mr13099841fa.34.1741367283068; Fri, 07 Mar 2025
 09:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com>
 <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me> <D8A73PQELZV8.24M3P13CM0062@proton.me>
In-Reply-To: <D8A73PQELZV8.24M3P13CM0062@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 12:07:26 -0500
X-Gm-Features: AQ5f1JrxaVyre9LG6qt0PJ6ougYb2AugTCfJPbcVEr_g1HFErh4RfnVy3bsTxKo
Message-ID: <CAJ-ks9m1o=uAeXYGvsM9KF3tAdf2GDTLghQCPCYAiLNV945Dcw@mail.gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:04=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Fri Mar 7, 2025 at 5:58 PM CET, Benno Lossin wrote:
> > On Fri Mar 7, 2025 at 5:41 PM CET, Tamir Duberstein wrote:
> >> In Rust 1.51.0, Clippy introduced the `ignored_unit_patterns` lint [1]=
:
> >
> > You link to the `ptr_as_ptr` lint though, is this a typo?
> >
> >>> Though `as` casts between raw pointers are not terrible,
> >>> `pointer::cast` is safer because it cannot accidentally change the
> >>> pointer's mutability, nor cast the pointer to other types like `usize=
`.
> >>
> >> There are a few classes of changes required:
> >> - Modules generated by bindgen are marked
> >>   `#[allow(clippy::ptr_as_ptr)]`.
> >> - Inferred casts (` as _`) are replaced with `.cast()`.
> >> - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
> >> - Multistep casts from references (` as *const _ as *const T`) are
> >>   replaced with `let x: *const _ =3D &x;` and `.cast()` or `.cast::<T>=
()`
> >>   according to the previous rules. The intermediate `let` binding is
> >>   required because `(x as *const _).cast::<T>()` results in inference
> >>   failure.
> >> - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
> >
> > These all seem very nice, thanks! I think it would also be a good idea
> > to enable `ptr_cast_constness` [1], since those are the other kind of
> > `as` usage that we should be doing via `cast_mut`/`cast_const`.
>
> I didn't mean to make this sound like you *have* to do the work. If you
> find the time and want to do it, then great, otherwise we can turn this
> into a good-first-issue :)

No worries, I will give it a go.

