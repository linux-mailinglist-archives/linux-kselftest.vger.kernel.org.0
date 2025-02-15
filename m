Return-Path: <linux-kselftest+bounces-26717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14782A36E52
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05C9170F87
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5DD1A2545;
	Sat, 15 Feb 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcSJPF+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3068623;
	Sat, 15 Feb 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739624686; cv=none; b=jbO9dtpY4ius61L+K8D4nPz4vah1Q7bJjMstqJ3bluQ9MvJtl9AYHGmBQ7uCYiHp6cRAhZf7E/XNy9NmmpX0rCEo+iGhmbvnHyf5lYpKCrru7qwCWVhYjgf3Sr4kqvBxigfI54Qd2E185mmAwGpraceT31M9jMFi5tEWCuMU/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739624686; c=relaxed/simple;
	bh=UWYnF2e2+P6Y/sAgEbI3iKHOLh7pG3OxwbBUXSU8RLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADR8B5gRNQz6xyoOYK9w803bCyh/CCH4bm1ys/n9q0sLGtUGVQ3ja3uvpfYZ+vp6ZW3tOfVWejelFkUHRp7fYD3yyJPVZkBsxuf8TJ6OZbHcAjjmqTz7UcDGE4iKpmChThKFOP6H9ET1ASQcIBC2f+HUTBX/4EC/i/blHuAeqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcSJPF+V; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3092643f4aaso8988231fa.1;
        Sat, 15 Feb 2025 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739624682; x=1740229482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQxqWePvHIT2picXONSU+2OFMt7hfUb4gyLS+js58fQ=;
        b=UcSJPF+VDAFsUGV3rRFrwtljkzXJvXJU53F+rc2OSww6cKL7caCjE+p2RwQ498268N
         NifbZ6jVWoJtqMuBMWBRaorKOEWEqw93mCcZCMwSxk/iT0wCmoCFmXlZhYH8D0GdMgVI
         P3/5OmskogeacO7U9uwfeGL7PHcv7RILVbN1+ciJPBAHPQ3dXKD8pccIosW9rqC5d1sF
         hX71Pdu1y1ptnHOQGtR/LlOJ8o67PS/zFzrdW2ZWwon+RwDfNCbc0xzaEXiQ2OP7vwpR
         WkFD6HIZmUC9Ayw8uoPTEFBUayYQ8At+Lt+3cIO4yp8s1foxnU9B1ecIdNpWL1u9c7jb
         47LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739624682; x=1740229482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQxqWePvHIT2picXONSU+2OFMt7hfUb4gyLS+js58fQ=;
        b=WNuF5sGHRBGEb7sSGm2uPr4bcJRUZsmOD7LoiHUOiM9Nf88IzIAuT/IpbJua4n/dYP
         iQBbNCxiCE+9jVn5C2jsK1YUIY/BKJOjpDaVfI1agvhssDXOXTLctYbvjWZKeIlJ9nNT
         z/BJjZj0578LVWFTw6QsEKBZT7l8u27o9jhzSKNNYYgh7wB9ivfG+VXFgm3iUG7lWQJL
         X06hoFlIGgo5V8LgYpOJsI3GcN9TeVIDjIBIVRubRVVuAI/QAaHJ9VvUjMF3UZLfgJgC
         5U772vTmkIcs4vXGkboI4s4d6Yonfyk2QdD9qiyERaM2xzVTLsbE3X4/bhdMzs8a/qC3
         qlAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6znYU7BGtP/VL6U8nQEA39TlCS6awcS6kMZJLfIgmdi9c+jV0bv8cBh2hk4aqk2kJoe2WmvA/BRPgLgL7+nY=@vger.kernel.org, AJvYcCW+DxO8YaI3QvbxX8TpIR6fk7nqhh6qNIdDoWa1T6N2CLP0lhHZlDB3QnLPtngLk+KxEICjo0tZSwKmLig=@vger.kernel.org, AJvYcCWYqp1YxnUNbOh/J5LY3PVHNahLrNnbweKvVTRi+iM0UHaI6SDFnHpef1BV05xYOKasH9G4+JuVSZLaY8C41PxL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rsDw0VyRTjirlyuxgfYh4KLRhUHp52gwUj9bXGxCKjv++63s
	8oVyd1eIkVGntCrwWr5OyvMEanJNeuKYDmoVT7wEK+YeeMJ8GbyQscgxeHulEeUquX2m4xxXtsr
	tcuOb4Cs9GfRvcB9ZQF36q//j8gtiz4zK
X-Gm-Gg: ASbGncsfK2l8QVenejSEZPfcSxcFTDDuioGHKlnCkfNVTV4r4RvXIeGdszAPduvDQEK
	AYiolC7xaGzsMpum9E6x1eXy/fCqFbsAmsgwYnqwm6yv1AEfyV2bYUB+/9fqcfKzd/Hho/N1cey
	VbwTNaKMZ1hET+QhzbZzzEmcgRRYyMxQ==
X-Google-Smtp-Source: AGHT+IGADOXK6A8/GEkATLBOdsyZof9/aX5TClGqjHqEuQqchxyCpH+3TIKuNfkvMgRdz1TQFw/1RcVFxaS9v1vh/NA=
X-Received: by 2002:a2e:95cd:0:b0:302:3356:35d7 with SMTP id
 38308e7fff4ca-30928b7439bmr7123121fa.18.1739624681465; Sat, 15 Feb 2025
 05:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-4-davidgow@google.com>
 <CAJ-ks9kwVz4sPdmqfTLVK-Z2C7WmXHpBhbe5_ozWBZnwxJ8HpA@mail.gmail.com> <CABVgOS=2f3Yg8Wb7qxneRC_+s-W_TQey083niujpZD3fYcfL_w@mail.gmail.com>
In-Reply-To: <CABVgOS=2f3Yg8Wb7qxneRC_+s-W_TQey083niujpZD3fYcfL_w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Feb 2025 08:04:05 -0500
X-Gm-Features: AWEUYZkO-deC3TTJ-Ho4qHpqUbaRWg5ash0Mk7jUJ1Y_Vd10hv4vuGqdu5AaPFo
Message-ID: <CAJ-ks9n92LCVQRuNMqKwMwGyLzJTnQXpHth4L8h19D0qoGUphg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rust: kunit: allow to know if we are in a test
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 4:03=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Fri, 14 Feb 2025 at 22:41, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 2:42=E2=80=AFAM David Gow <davidgow@google.com>=
 wrote:
> > >
> > > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > >
> > > In some cases, we need to call test-only code from outside the test
> > > case, for example, to mock a function or a module.
> > >
> > > In order to check whether we are in a test or not, we need to test if
> > > `CONFIG_KUNIT` is set.
> > > Unfortunately, we cannot rely only on this condition because:
> > > - a test could be running in another thread,
> > > - some distros compile KUnit in production kernels, so checking at ru=
ntime
> > >   that `current->kunit_test !=3D NULL` is required.
> > >
> > > Forturately, KUnit provides an optimised check in
> > > `kunit_get_current_test()`, which checks CONFIG_KUNIT, a global stati=
c
> > > key, and then the current thread's running KUnit test.
> > >
> > > Add a safe wrapper function around this to know whether or not we are=
 in
> > > a KUnit test and examples showing how to mock a function and a module=
.
> > >
> > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > Co-developed-by: David Gow <davidgow@google.com>
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > ---
> > >
> > > Changes since v5:
> > > https://lore.kernel.org/all/20241213081035.2069066-4-davidgow@google.=
com/
> > > - Greatly improved documentation, which is both clearer and better
> > >   matches the rustdoc norm. (Thanks, Miguel)
> > > - The examples and safety comments are also both more idiomatic an
> > >   cleaner. (Thanks, Miguel)
> > > - More things sit appropriately behind CONFIG_KUNIT (Thanks, Miguel)
> > >
> > > Changes since v4:
> > > https://lore.kernel.org/linux-kselftest/20241101064505.3820737-4-davi=
dgow@google.com/
> > > - Rebased against 6.13-rc1
> > > - Fix some missing safety comments, and remove some unneeded 'unsafe'
> > >   blocks. (Thanks Boqun)
> > >
> > > Changes since v3:
> > > https://lore.kernel.org/linux-kselftest/20241030045719.3085147-8-davi=
dgow@google.com/
> > > - The example test has been updated to no longer use assert_eq!() wit=
h
> > >   a constant bool argument (fixes a clippy warning).
> > >
> > > No changes since v2:
> > > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-4-davi=
dgow@google.com/
> > >
> > > Changes since v1:
> > > https://lore.kernel.org/lkml/20230720-rustbind-v1-3-c80db349e3b5@goog=
le.com/
> > > - Rebased on top of rust-next.
> > > - Use the `kunit_get_current_test()` C function, which wasn't previou=
sly
> > >   available, instead of rolling our own.
> > > - (Thanks also to Boqun for suggesting a nicer way of implementing th=
is,
> > >   which I tried, but the `kunit_get_current_test()` version obsoleted=
.)
> > > ---
> > >  rust/kernel/kunit.rs | 66 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 66 insertions(+)
> > >
> > > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > > index 9e27b74a605b..3aad7a281b6d 100644
> > > --- a/rust/kernel/kunit.rs
> > > +++ b/rust/kernel/kunit.rs
> > > @@ -286,11 +286,77 @@ macro_rules! kunit_unsafe_test_suite {
> > >      };
> > >  }
> > >
> > > +/// Returns whether we are currently running a KUnit test.
> > > +///
> > > +/// In some cases, you need to call test-only code from outside the =
test case, for example, to
> > > +/// create a function mock. This function allows to change behavior =
depending on whether we are
> > > +/// currently running a KUnit test or not.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// This example shows how a function can be mocked to return a well=
-known value while testing:
> > > +///
> > > +/// ```
> > > +/// # use kernel::kunit::in_kunit_test;
> > > +/// fn fn_mock_example(n: i32) -> i32 {
> > > +///     if in_kunit_test() {
> > > +///         return 100;
> > > +///     }
> > > +///
> > > +///     n + 1
> > > +/// }
> > > +///
> > > +/// let mock_res =3D fn_mock_example(5);
> > > +/// assert_eq!(mock_res, 100);
> > > +/// ```
> > > +///
> > > +/// Sometimes, you don't control the code that needs to be mocked. T=
his example shows how the
> > > +/// `bindings` module can be mocked:
> >
> > [`bindings`] here, please. There are two more instances below but
> > those aren't doc comments, so I don't think bracketing them will do
> > anything.
> >
>
> Done in v7. Alas, I'll have to keep getting used to the differences
> between kerneldoc and rustdoc...
>
> > > +///
> > > +/// ```
> > > +/// // Import our mock naming it as the real module.
> > > +/// #[cfg(CONFIG_KUNIT)]
> > > +/// use bindings_mock_example as bindings;
> > > +/// #[cfg(not(CONFIG_KUNIT))]
> > > +/// use kernel::bindings;
> > > +///
> > > +/// // This module mocks `bindings`.
> > > +/// #[cfg(CONFIG_KUNIT)]
> > > +/// mod bindings_mock_example {
> > > +///     /// Mock `ktime_get_boot_fast_ns` to return a well-known val=
ue when running a KUnit test.
> > > +///     pub(crate) fn ktime_get_boot_fast_ns() -> u64 {
> > > +///         1234
> > > +///     }
> > > +/// }
> > > +///
> > > +/// // This is the function we want to test. Since `bindings` has be=
en mocked, we can use its
> > > +/// // functions seamlessly.
> > > +/// fn get_boot_ns() -> u64 {
> > > +///     // SAFETY: `ktime_get_boot_fast_ns()` is always safe to call=
.
> > > +///     unsafe { bindings::ktime_get_boot_fast_ns() }
> > > +/// }
> > > +///
> > > +/// let time =3D get_boot_ns();
> > > +/// assert_eq!(time, 1234);
> > > +/// ```
> >
> > Isn't this swapping out the bindings module at compile time, and for
> > the whole build? In other words cfg(CONFIG_KUNIT) will apply to all
> > code, both test and non-test.
> >
>
> I believe so, so this is probably something best done only in test files.

Why would you need conditional compilation of this kind in test files?

What I was getting at with this comment is that this example might
mislead a user to think that this is how they should imbue their code
with test-specific behavior, which is not what this will do. Instead
this would break kernels built with CONFIG_KUNIT, which I think is not
where we want to be going. Right?

>
> Ideally, we'd have support for something like the KUnit function
> mocking features here, but that's horribly C-specific at the moment.
>
> > > +pub fn in_kunit_test() -> bool {
> > > +    // SAFETY: `kunit_get_current_test()` is always safe to call (it=
 has fallbacks for
> > > +    // when KUnit is not enabled).
> > > +    unsafe { !bindings::kunit_get_current_test().is_null() }
> >
> > Nit if you care about reducing unsafe blocks:
> >
> > !unsafe { bindings::kunit_get_current_test() }.is_null()
> >
> >
>
> Huh, I thought this wouldn't work, but it's working fine for me here,
> so I've made the change.
>
> Thanks!
>
> > > +}
> > > +
> > >  #[kunit_tests(rust_kernel_kunit)]
> > >  mod tests {
> > > +    use super::*;
> > > +
> > >      #[test]
> > >      fn rust_test_kunit_example_test() {
> > >          #![expect(clippy::eq_op)]
> > >          assert_eq!(1 + 1, 2);
> > >      }
> > > +
> > > +    #[test]
> > > +    fn rust_test_kunit_in_kunit_test() {
> > > +        assert!(in_kunit_test());
> > > +    }
> > >  }
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >
> > >
>
> Thanks a lot, these should be fixed in v7.
>
> Cheers,
> -- David

