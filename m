Return-Path: <linux-kselftest+bounces-28521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7745A573A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0851898B5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDC1A76DA;
	Fri,  7 Mar 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/YkaMOp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8552F88;
	Fri,  7 Mar 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383145; cv=none; b=O99e2R12qH4gDbriRtd7Q2V9zAY2An6MlMGZSP59USeL/X6dlD65zkva7Qx0GKNJIIJH/hW98N8VQWY5zvKxUSwEVPOJDyvL3zM+PSbUY6hY4u/51Y3dBxPoU+g98OX5WjwTJgei37ufFOcF42krK57qw1F312J5UhBuyO4HP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383145; c=relaxed/simple;
	bh=ea5QbX6IzEXBGeiREOq3fPlIiSB5nrJrrq+ZM6Dhr4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT31DxNYXNPu5szWAJom0mx9DgJiKKgFDh/7mX2wtWK5Oq8uEt4NAEV6jogka9Tsnz95rxvTcnJCddx26pCNm6SMt+hQ7KbvLRVv5T/YquWwSzadxbETK9J0HN67zm8+xf154PlBzjFcvU9AYG4wGIijogx8hGisY/rTxFY7TeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/YkaMOp; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613802a04so24956051fa.2;
        Fri, 07 Mar 2025 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741383142; x=1741987942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARuhzLHKgFAOlu2Q7LP5aYiWyJne5EpXab6RXQoDcXE=;
        b=E/YkaMOpGZhUOr4BLU9lFjNXPB0d/yJu9uubcj/CvoyskjGjkaa+QYmPHxflBHG1Cr
         ljBvMgx7nkGOhebtsNKgXWXcr5hursgwlSDrWslqEVfGGGSco/ZxLNUfU28LzhvQLRaN
         kYN5wK3rD0xUTX0XjUZKLm29YP7Xd+zRtuuQJ01APGTG6hv3Eg6U6JWRXrbBiYcW/+cW
         IuCA6g+ttRj8qriNCniRvwh1SGNg75s8BRYVxRmPwUrLAOMwSzw1tMPXShplv54DU3Hx
         D356fv2RhRdEkFi19AqaZWavVH9YCLP0+Y2EFY6CRbkmYlGdfZrwAS5HuQhqEc553Q+P
         I5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383142; x=1741987942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARuhzLHKgFAOlu2Q7LP5aYiWyJne5EpXab6RXQoDcXE=;
        b=Nr94Mx+AXzvP3cfUO0jA50LuReVW2+aDlvXwDgMyk3Bujj2NzRGpemhoNuRtZCbKtJ
         5+lv0N2oeeMSqWvHT8yOqHsiPlwlbTruVnoJEO6XCb1oXzH+bDPjpJdtM6wYwNVYsfw6
         Mpudah5hDDkVA20kq9wH+FHFNp4nLXDlmexDmbMQTNpUs9tGtJ/uf8Ldu9ZwSU1IcFer
         sXMerNakDoUtT62tFp3P8TdbWNkhWLalpYS/gCnUJzuYuVltetA8//kxs08BTWTPZ99k
         LHYDMN/UcLV5zDLqIkcvbPLJeSXgKn5OaO4n+F5ME1c/vfWN4lWONzUkAhptTrSviLvv
         vLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUApOfytG7hrHuLNkRDsPCwCIzTz2RUIDmTbFURxBiX226/72mXdZUYEhV99GCtG4GmgO4r08PJM8PSFB/E@vger.kernel.org, AJvYcCVJIbYgUPL11Y7RHLebRd4p42nxrneMrpAhjJAHiZxW0BXzsSRWwQqgnJqJI3rElUh+pHUO0chTkt2n5Lw=@vger.kernel.org, AJvYcCVcknB92lOKIEV6JurI1hkZpBBNrViu7VbzNK+hV+8zO1LzGW1zRrCDE6fIGK2XLo7fRwV/68itXqv3@vger.kernel.org, AJvYcCXMyH38juIP+XRMcWk9Z1ox1Dg3Be983ioNr9RWdk8DPtZyVLcBzJdUkiEQYneMD/q6b8wfWf8meECtXWioZ6k=@vger.kernel.org, AJvYcCXUAFS0SUPBZf87wbA6YnYsWTlDUEv0dnYybK97bFkSKW4tiZdKMVW75LfEWWOvjawChKfMGg5NFHKG3jQJPcpO@vger.kernel.org
X-Gm-Message-State: AOJu0YygneeLghaMLagOCB1yVA4akUnaUIMWq6zrPXBuhztyvtmiioiA
	gjSzm1MMKnV1OXEyWgopWPfKuCxnBPuz8/6MoLHnrhxQeOs0uSJ0CnZly7LqkSKNEX674zInnWI
	hJgbjFX5xTQySHw3rAdWkbOm17eU=
X-Gm-Gg: ASbGncuPiolM+chTK6FWZF4YKc1LRNxoQoTo6uKN7kFerXNkjsZNfC68iIj1LCUCaKr
	DfGvnysG06S1uJirYhvfzW5z/6g3zRoBvYbANn2mySP5ktyvu9jgDNFl9QZyoHNVw4oRFqDHQ7E
	fgylDU5YS3qEjqv0VRdZhjrdsS3Sakywh6uZaWKY900t4p9vNLqpT1Cr+LHFg3
X-Google-Smtp-Source: AGHT+IFdsPweWJvHGLz80jL2G7JVEo6FQUSZN8RROpkrVaDfRFA5+62kZX+VW47Fc+dzP9GteUEXyi+zFHV0PgHEd2A=
X-Received: by 2002:a05:651c:1542:b0:30b:d5ed:55c7 with SMTP id
 38308e7fff4ca-30bf465adc2mr19017741fa.36.1741383141346; Fri, 07 Mar 2025
 13:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com> <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
In-Reply-To: <D8A6YVP8B1UB.38AHIB0LMO85Y@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 16:31:45 -0500
X-Gm-Features: AQ5f1JpSIMesRtsEKl89gOnukKxYXJaio0pmeP0gT1zPDpJ0Rn9dPatry3rsobM
Message-ID: <CAJ-ks9mnDzD2ZQ1ebvJVe8bvHtc2b3E=ORVjhWJ7=MjgmqbpBg@mail.gmail.com>
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
>
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
>
> There are still some legitimate uses of `as` casts, when unsizing
> values. I don't know if these two lints can trigger on those, it would
> be nice if they don't. So those should continue to use `as`, but other
> than that, there shouldn't be any `as` in our code :)
>
> [1]: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_c=
onstness
>
> (I will take a look at the patch itself a bit later)

I'll go ahead and send v2 soon where this has become a 5 patch series.

