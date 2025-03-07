Return-Path: <linux-kselftest+bounces-28504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E2A56EAC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B56169B4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1758D23F28D;
	Fri,  7 Mar 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnidXwMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B951219A8D;
	Fri,  7 Mar 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367267; cv=none; b=B+LYDDOZiyC6wbPlg80rIy58eCDbpAXImjVDGj923zVl+JQqSmphKM8V/9hQZgTIL+H3vgWPyoLKpt9MeBepyZiaAScL/6s+g4+ovcEm8Z5UBdZOCTJk4JAol/Vce2mLAmyWXyVhAqWxqw6PD6mGTRpqDfsVivCbmWLHgc3jJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367267; c=relaxed/simple;
	bh=S5qIYkVZBV7yZBHxnN6x+MjW6oLrkYGeDtqvNtCdH3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gqu0Aj8PesbumZLwPk0a5I9DSeiHrUj5PdTaImmlb3G4KnYqzKC0tt2nr92BdwAUROX5k5sHJBzmlcJ7V+mP/kwMQcINJ7uyptRqwQJ2PBK5d8VXxeJfCqf1Mk3Ct2Dc2CHB7m+zXuGIkPcbKwk6aAdWIH9jhpJaTVKCKDzcvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnidXwMU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso5459111fa.3;
        Fri, 07 Mar 2025 09:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741367263; x=1741972063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BZNW8FHp0kiK+VBa2ZjVpOPfhh3unjQcywgiqPkxCk=;
        b=HnidXwMUtS5OUIY27YfPFh/vbdWXI/CaJwk6xxk+9g8Z0uLfzefBSGbY/y1ZbVhY0V
         pmVKvcnlMQNig8IQIkr/WWmvQE7lIORdHsh+qusHKgmffNaJIfpHq2mSDFEBp9pE3Rzt
         g/i+k36i4qXwamKW4+nAmAbPJqaN7Twwf9MQg9RbS5DWpuiKfP1frXaJ7MzePkDu/fsk
         oDhnvqzJiqerCFHtdRtyr50uIFIEmWFWgGqLo2Lfax8z+eC4ME7i/+mbtFK2yZPzyd22
         9Tr1B7uZLLHnZP9OM//7r3zFTYSa3Z8l6H5JxJjXumxF/+V8DEflFdR3DnlQsORA52dw
         nGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367263; x=1741972063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BZNW8FHp0kiK+VBa2ZjVpOPfhh3unjQcywgiqPkxCk=;
        b=XmGJId8XR3kBQ+xS7irJjrcw60hP0VKmkEO95+4uLm61nREo8DU04ucY4IN8ZChdcu
         igH3ck9xljr1PobI7l0lNinpxgfy7T+Waec5gl/+Q0zzcP5519sa1UdInvi+Wu8BCKaJ
         0ORMEr7Mfh0pq9aVTvAWrYgMB/YNisa/q4j16utEd45R56rJmARD5fizE/qODULjF/qJ
         QU7UXTJrzatNEMYgWGQyARH46DbinchlV1dLxKs1nR3Zy1bXe/I1PuLwXehez0yvihCc
         +EiQuzqfie9AAFZXsSSgkZMaAy6VBTyc882s0uKtjZquXLc26hmvKz48AUCvtvLJAEry
         nmAg==
X-Forwarded-Encrypted: i=1; AJvYcCU0VulEish7jC5suyv4uhPlnelqUVIAC3DOVOLmWWVMV767TSKQ+0VY9ijwXZmfEdAuMKqp5YFwaIju9OWqMSk=@vger.kernel.org, AJvYcCUW5HifHR/2ynmHD+AGVqObWj7tRHKIg82LQG1Pc9VHmge6ZbU0kcvZHoJYWH8UOASDewkEtl5ySH8NlnPG@vger.kernel.org, AJvYcCUlfXSPVW52Re5GAcu2laJvGaDHiWXt4QL2TPvnPzIgo+hHOAH3U8aJ+AAYKfqzOsjJVzQAuoxXyQEs@vger.kernel.org, AJvYcCXU9h87YT4nJ6DoQ5fxDbCtYmQdkt6yc2lSFeP4lfqaVdqXy0t9ZZWCxmJ6pvEJMlUzoPcyj2I15cTz48/4Bh4B@vger.kernel.org, AJvYcCXkt05XnBVw+cfveLzDYfoi1BrpRKHHUZnBSCMIxRQuB/i6Q7Secnx1nTYE6NkRziWa2WR6MfkV0z9mV8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTFQiE3z7hVWEIZBi6oVCdpz2rWFj8izZmgPwjDyVu2PP5ydQ
	0hIsWzEFMKUWOEpQxksK6JNN1TnALiIA3h1aTSoJ9qqJ8Y3+JBEwMPANh8a4gzRlRWjp1O/msl9
	DZeACXbRBcdm54bn6l27RQaRmNHo=
X-Gm-Gg: ASbGncvHshpf2p1wQupdnXP+CKux/LYklH8/sEIyX1scfsv5c6vOjsVCSFSrkkvsFh0
	jTO6X5NrjpvnqbsVqx5HTSTAD++chL89JeJgAta5f49o941WxiR1/A2COsxR1Kix8K/t1lAfFbw
	TEvaDpXe1acgbfQ1K/Oc2bYCuA/g4EuSTcik7HvETb6otasAJrjY4FLeePmOc=
X-Google-Smtp-Source: AGHT+IFIb5z971lhXc5saInEcfYOi3I1KErFFg07/k8yWRzRHQAfmKEhUHzX32MGl7sx7pN2RfxR4+pC51CbdsJTX6U=
X-Received: by 2002:a05:651c:b12:b0:30b:bef9:dff2 with SMTP id
 38308e7fff4ca-30bf452fb5bmr18891761fa.21.1741367263175; Fri, 07 Mar 2025
 09:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com> <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
In-Reply-To: <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 12:07:06 -0500
X-Gm-Features: AQ5f1JqeSO5a13ffraOywBFoV7ZrLltPpc6k7orJj2SVA6zJBK3rhseBvuYgrA4
Message-ID: <CAJ-ks9kFze-neAT7mHcDWSLvV_AsAS0NGeWeoXLUkqnyEDwSag@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 11:58=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Fri Mar 7, 2025 at 5:41 PM CET, Tamir Duberstein wrote:
> > In Rust 1.51.0, Clippy introduced the `ignored_unit_patterns` lint [1]:
>
> You link to the `ptr_as_ptr` lint though, is this a typo?

Oops, yep, a typo.

> >> Though `as` casts between raw pointers are not terrible,
> >> `pointer::cast` is safer because it cannot accidentally change the
> >> pointer's mutability, nor cast the pointer to other types like `usize`=
.
> >
> > There are a few classes of changes required:
> > - Modules generated by bindgen are marked
> >   `#[allow(clippy::ptr_as_ptr)]`.
> > - Inferred casts (` as _`) are replaced with `.cast()`.
> > - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
> > - Multistep casts from references (` as *const _ as *const T`) are
> >   replaced with `let x: *const _ =3D &x;` and `.cast()` or `.cast::<T>(=
)`
> >   according to the previous rules. The intermediate `let` binding is
> >   required because `(x as *const _).cast::<T>()` results in inference
> >   failure.
> > - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
>
> These all seem very nice, thanks! I think it would also be a good idea
> to enable `ptr_cast_constness` [1], since those are the other kind of
> `as` usage that we should be doing via `cast_mut`/`cast_const`.

There's also `as_ptr_cast_mut` which could be good to enable.

> There are still some legitimate uses of `as` casts, when unsizing
> values. I don't know if these two lints can trigger on those, it would
> be nice if they don't. So those should continue to use `as`, but other
> than that, there shouldn't be any `as` in our code :)
>
> [1]: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_c=
onstness
>
> (I will take a look at the patch itself a bit later)

Thanks!

