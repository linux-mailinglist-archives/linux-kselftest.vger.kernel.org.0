Return-Path: <linux-kselftest+bounces-30889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC10A8A633
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B0E16C49E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E1221D9B;
	Tue, 15 Apr 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsQ/7fyr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF711B0430;
	Tue, 15 Apr 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739963; cv=none; b=O4NcLwcSRlaxjJxXmVg3IsGFWGFoCV5M60y8SycnWdKVNB0xctShe3SYQLU6TjN05ZkaJuRFVle9MjOLkVRgKg8PJRKTdxCOk/9kVYrPzVO6rtY1FYgs4PdtbWrk/fVKWFAFyrvrRTCXUlS3N1nHuSos6J1WB1pGnFsBlHoonD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739963; c=relaxed/simple;
	bh=6vqyFdgSOE1G1XSEDXKMrW726YFh+Kp5ylehEemLq3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvxjJ8/bFR1b7cqoqyPD/yDASc0jH8wc9PpEaY8jO2P9mzWn0bTVcMbUcEsrVBYAsHn/P51pl/nfd4Nloobhzsa4S4NJOoII3q0vkj7nLYJvq0lYxPC5UK7HLlqMphztFcCM+3ZT/ZNbu8GLdFn77aQig5hz3Xl5AVluS7AFeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsQ/7fyr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30effbfaf61so63742891fa.0;
        Tue, 15 Apr 2025 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744739959; x=1745344759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy3kd4y2fU3jMELcdzdDFGgDJCCLaq6b5me66/U55f4=;
        b=nsQ/7fyr0HJTTFVzyegRuB6840if4kY6mzutBveQxtDSi1AZQuIsGpGCorXaxilBDO
         nWi2bQ+w247jBXoEVhq+XnFvu/OuOCgKhtPO6px/m7LQd1zY1moS54U4x6NGoBxxAsmE
         n6erCRCLzSOQNwjsEs4cVVUVS65d4NsFS2z7GvahQECJgvDyUrCwWMae8D0/VSMPbZ+I
         j5Q70UPgQxj0pwV9zcrP6WrSlfBW+dNHkkpMTqjKPm/FPBCIhs9jFLVf8Bm47yStuVjr
         sFCIVwSU0luWc7S2VM/L8shHc2s1GiekfzOdMJZgiBj4fK+YwfydR0zcH88LmO3ibuAk
         Ocvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739959; x=1745344759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy3kd4y2fU3jMELcdzdDFGgDJCCLaq6b5me66/U55f4=;
        b=hTLgyF2ZM1ekp8BIMO8aI980pg2l5EgoxfRw0+HvmH16MnJgyKs4vI837IwZ6amYGz
         xa0vKd/ThXzPdLKwXreYcKj/jM4eJe+w1VVBWvvyygW/7f/OUeTWKymXh8oab9XE25hX
         E2yVQ+PcauOfzMNo6QiK2GTLDFbDzEOWRBaW34pxvLeBJylI/aTgza1J5lZTwrBCxIUz
         F9CCbaxZZiNM98fQQotvI+FrZwIXn7q0MYNLAL10yGgNzUm4EPOQdAABnnraoJKehBox
         47R7M7BnVZhZwZl7hULo/tfMQk5mm0DzGRGZIr/OAZ3v+Swl1WeNEUYTlSIeyh9S7xEJ
         170Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8Vc3BybxQj7fzX35NfYdphV+sf4ntR5xIQziIvrcy0WoFXUaUkGdqSiSKna/rU8igsFJvLmyBWlKu+STgY+gp@vger.kernel.org, AJvYcCUKJYDSagEDfznHlkNtKYYJIB8zo+Cxiv3nu1YMSqYTSeOdx997CW4EOCYISMJpxL9Ch4IvN+e0ZHlhl8s7064=@vger.kernel.org, AJvYcCVHM5UvS6mIyiZuQv3ycOTHWTcgLu3GvimB2KR+Zo36WIuB5ko1koYSueHXGkhOa58JJKm7clyWiLfjTfDX@vger.kernel.org, AJvYcCVSfS6CjXfy70HMLwD7PfzNEcyjeAVcvhxYUY/zoL+QuClmpBHhQExFK2Cs/hNz+2SR1+YZowTwdvxm@vger.kernel.org, AJvYcCX5PKagXy3BXuSBcR9yD8RvjVpxc0JDWXKaGeYkKR0YDN5E7kpkkGPFROlnTTPyvUGkBdk0+ETIhH6fRfuG@vger.kernel.org, AJvYcCXKL1U4DC0KS8NxvgfGObzzIQtWqrFMfpKB9atpM/4zY5RLiJrsXqsyROlkq0kuv5ti4ze6ESiDd4U4@vger.kernel.org, AJvYcCXofrmID0mAnwI4o4U+vVp/KcxOzOtXjHaW0ZGqSOkN0pa6VO0jk79yLiu/JoAdEq32yWnYxcqT4SSRlp4=@vger.kernel.org, AJvYcCXxWv1Nu00fpBJM8/VauONXcyX9RRnxrR4r7zHMVk6UzlVpM0aup1sr9HCswPhsJ+Pi0Ft+zCBM@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8JEPpqlzmdKUgoGV7MwuvOStJt6UVkaTChsBq5Zx978u1oHb
	6jbero2BhTBPaqvDWvhXrK8886A4jfTpGTdTZ3PdaAsaMDHV+9MaH2MYmr4JilPmYcHxfp50IHg
	22ZZVLqBa66tTFtHJnoWp46wXF8E=
X-Gm-Gg: ASbGncur5pqLa993wap1Pr98T/kP07c8hI+37hD/VN+sWaj/DL/hfkP1qTiaJpT+lu7
	JfUyFTVWJFl2iHQhj0pfkkxnB0CIxUPXE5zM5KWk85Y79CD0fnfoWWsKBuVVHXMWFKS/xUWsO20
	OaJljxyuaZd3FPOyFjPVF6zjw41+IK61XtnSye7Q==
X-Google-Smtp-Source: AGHT+IEUNTX9p1/kWuAn/OzmQY0lqmIBQmlqMfDN8hWejN/w4TanfAbwc4EzQ3SRD5P4AkdcwY/5HBDJLXd2VI4DjpM=
X-Received: by 2002:a05:651c:510:b0:30b:c328:3cdc with SMTP id
 38308e7fff4ca-3107b567391mr1618391fa.2.1744739958790; Tue, 15 Apr 2025
 10:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
 <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com> <67fe9975.c80a0220.1b5785.66e7@mx.google.com>
In-Reply-To: <67fe9975.c80a0220.1b5785.66e7@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 15 Apr 2025 13:58:41 -0400
X-Gm-Features: ATxdqUFTqoXZoDoJwXjqPF28obJ4nUC4URNzmlSsg0OP0AFuuXDbvBbZrCOdGZQ
Message-ID: <CAJ-ks9mzyfvsxkyud_wLXfhLD_zP95bivCQ9i2aC-3ea=Y7+0A@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Boqun, thanks for having a look!

On Tue, Apr 15, 2025 at 1:37=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Apr 09, 2025 at 10:47:23AM -0400, Tamir Duberstein wrote:
> > In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
> >
> > > Using `as` casts may result in silently changing mutability or type.
> >
> > While this doesn't eliminate unchecked `as` conversions, it makes such
> > conversions easier to scrutinize.  It also has the slight benefit of
> > removing a degree of freedom on which to bikeshed. Thus apply the
> > changes and enable the lint -- no functional change intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_=
ptr [1]
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  Makefile                 |  1 +
> >  rust/bindings/lib.rs     |  1 +
> >  rust/kernel/device_id.rs |  3 ++-
> >  rust/kernel/fs/file.rs   |  3 ++-
> >  rust/kernel/str.rs       |  6 ++++--
> >  rust/kernel/uaccess.rs   | 10 ++++------
> >  rust/uapi/lib.rs         |  1 +
> >  7 files changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index eb5a942241a2..2a16e02f26db 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -485,6 +485,7 @@ export rust_common_flags :=3D --edition=3D2021 \
> >                           -Wclippy::no_mangle_with_rust_abi \
> >                           -Wclippy::ptr_as_ptr \
> >                           -Wclippy::ptr_cast_constness \
> > +                         -Wclippy::ref_as_ptr \
> >                           -Wclippy::undocumented_unsafe_blocks \
> >                           -Wclippy::unnecessary_safety_comment \
> >                           -Wclippy::unnecessary_safety_doc \
> > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > index b105a0d899cc..2b69016070c6 100644
> > --- a/rust/bindings/lib.rs
> > +++ b/rust/bindings/lib.rs
> > @@ -27,6 +27,7 @@
> >  #[allow(dead_code)]
> >  #[allow(clippy::cast_lossless)]
> >  #[allow(clippy::ptr_as_ptr)]
> > +#[allow(clippy::ref_as_ptr)]
> >  #[allow(clippy::undocumented_unsafe_blocks)]
> >  mod bindings_raw {
> >      // Manual definition for blocklisted types.
> > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > index 4063f09d76d9..37cc03d1df4c 100644
> > --- a/rust/kernel/device_id.rs
> > +++ b/rust/kernel/device_id.rs
> > @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, =
U> for IdArray<T, U, N> {
> >      fn as_ptr(&self) -> *const T::RawType {
> >          // This cannot be `self.ids.as_ptr()`, as the return pointer m=
ust have correct provenance
> >          // to access the sentinel.
> > -        (self as *const Self).cast()
> > +        let this: *const Self =3D self;
>
> Hmm.. so this lint usually just requires to use a let statement instead
> of as expression when casting a reference to a pointer? Not 100%
> convinced this results into better code TBH..

The rationale is in the lint description and quoted in the commit
message: "Using `as` casts may result in silently changing mutability
or type.".

>
> > +        this.cast()
> >      }
> >
> >      fn id(&self, index: usize) -> &T::RawType {
> > diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> > index 791f493ada10..559a4bfa123f 100644
> > --- a/rust/kernel/fs/file.rs
> > +++ b/rust/kernel/fs/file.rs
> > @@ -359,12 +359,13 @@ impl core::ops::Deref for File {
> >      type Target =3D LocalFile;
> >      #[inline]
> >      fn deref(&self) -> &LocalFile {
> > +        let this: *const Self =3D self;
> >          // SAFETY: The caller provides a `&File`, and since it is a re=
ference, it must point at a
> >          // valid file for the desired duration.
> >          //
> >          // By the type invariants, there are no `fdget_pos` calls that=
 did not take the
> >          // `f_pos_lock` mutex.
> > -        unsafe { LocalFile::from_raw_file((self as *const Self).cast()=
) }
> > +        unsafe { LocalFile::from_raw_file(this.cast()) }
> >      }
> >  }
> >
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 40034f77fc2f..75b4a18c67c4 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -28,8 +28,9 @@ pub const fn is_empty(&self) -> bool {
> >      /// Creates a [`BStr`] from a `[u8]`.
> >      #[inline]
> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> > +        let bytes: *const [u8] =3D bytes;
> >          // SAFETY: `BStr` is transparent to `[u8]`.
> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> > +        unsafe { &*(bytes as *const BStr) }
>
>         unsafe { &*(bytes.cast::<BStr>()) }
>
> ? I'm curious why this dodged the other lint (ptr_as_ptr).

The reason it has to be written this way is that BStr is !Sized, and
`pointer::cast` has an implicit Sized bound.

Perhaps the lint is smart enough to avoid the suggestion in that case?
Seems like yes:
https://github.com/rust-lang/rust-clippy/blob/d3267e9230940757fde2fcb608605=
bf8dbfd85e1/clippy_lints/src/casts/ptr_as_ptr.rs#L36.

>
> >      }
> >
> >      /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix=
`].
> > @@ -289,8 +290,9 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> R=
esult<&Self, CStrConvertError
> >      /// `NUL` byte (or the string will be truncated).
> >      #[inline]
> >      pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) =
-> &mut CStr {
> > +        let bytes: *mut [u8] =3D bytes;
> >          // SAFETY: Properties of `bytes` guaranteed by the safety prec=
ondition.
> > -        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > +        unsafe { &mut *(bytes as *mut CStr) }
>
> Ditto.
>
> >      }
> >
> >      /// Returns a C pointer to the string.
> > diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> > index 80a9782b1c6e..7a6fc78fc314 100644
> > --- a/rust/kernel/uaccess.rs
> > +++ b/rust/kernel/uaccess.rs
> > @@ -240,9 +240,10 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<=
u8>]) -> Result {
> >      /// Fails with [`EFAULT`] if the read happens on a bad address, or=
 if the read goes out of
> >      /// bounds of this [`UserSliceReader`]. This call may modify `out`=
 even if it returns an error.
> >      pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> > +        let out: *mut [u8] =3D out;
> >          // SAFETY: The types are compatible and `read_raw` doesn't wri=
te uninitialized bytes to
> >          // `out`.
> > -        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUni=
nit<u8>]) };
> > +        let out =3D unsafe { &mut *(out as *mut [MaybeUninit<u8>]) };
>
> Ditto.

Same rationale here.

Cheers.
Tamir

