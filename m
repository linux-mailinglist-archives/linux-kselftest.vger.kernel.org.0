Return-Path: <linux-kselftest+bounces-31078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E3A923D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08BD8A0013
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC952561BE;
	Thu, 17 Apr 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeDchE+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F02561A9;
	Thu, 17 Apr 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910242; cv=none; b=PS64RpLelbKn5jLWCMZc8HNATtOu/vJG/Pv1KBpz1CBUnAg3ktMzKhFJlPavyq2ZeFp2X/KZGYh+MXyvRoie+ylihLjmlf9UgB4F/k+xzuZu9aW8wSqCr7HCZfyKk4x3UFtd+pjLt7d1gWTN2R8a9u6yzp7mzVRLAUUuqq0Rvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910242; c=relaxed/simple;
	bh=/EffTIMfBY6ZxDt67+newxOD/AsdI/VT70L648L7STw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj1FCtiv6K+Kv+ded2qS/3i0kJGkNRNYvQa/PikXNHgKeL6yU13QPzJLB2s4lUPKT4NUp4c5QTneVjZjor1AQ1ElQ/Mex0h0b9LPjJMeXppZ35a0sn5BF5qVwEg4vJ7oI4o95uZGRwZzi04v9gs2tEMC6LruOaYH4uFhUCJdZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeDchE+R; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so1434256e87.2;
        Thu, 17 Apr 2025 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910238; x=1745515038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irzU/UEG8kWXnz04y8/ocsz9zbHZsT12yci/WpMA35E=;
        b=TeDchE+RbkHZua77Tl0PqBW0P/lAVpkIHOx4JwyyWpT9+ZoCVloY4mQX3PyFEXbnxV
         0e8dGgWHgop4KpkKlGpHTcu/CyTB7zkG3TUQdxHeRHPWxAdZ4Y1QAVJTRjyiDWC16IbD
         jjLZXMC3qa/9b0bDLXg4I3CTfTfReONTjO34TPS3jLdj/8ZcvCvK3jSfgpa67SHaSKBP
         d1qf3lHQQ6Yq7QwEz1ptK5uheECdsoAp5oi6RJ+gTzsFVy/i++D88Sp2rGocRJtbGA/l
         Mmn3xRgENVR5oRlxtLj4rnExQdl/CRNaeUdMuoEhHB09W4u9UXZXlcb8Dz2vU4jVM6Vg
         2QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910238; x=1745515038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irzU/UEG8kWXnz04y8/ocsz9zbHZsT12yci/WpMA35E=;
        b=PehrwBsYE01pMiBQUgP0dY9WBardOjdgWIbQmeJbTzK4vZsSmBnxsAaZ548Azu8brJ
         uKfOVPti7N1HQtxvxZCmUXbHs+Ccb2QJfrB+RRuPbOKyyVar8AbnD0jO+EpHODDgRqw9
         r1aZCuYOg/SLJN1NTdMtenKqySllNmyJyPAEy84nqdApxlDLpqYT24bs0utTyEMDD2io
         sItfOb/OVEkFW0eiTVbXtoWVZyXpbMBHHPI0ik8+ViAjLMnuIln/1yBcdnhVTCnjH0EU
         3JDui3kv0BMxvKa/BxMitXlQQT9sEOBbxpGXmk2kP2OTPWxGFdwylKHzJ5h9hGf7J8hP
         BT1w==
X-Forwarded-Encrypted: i=1; AJvYcCV9IELlLX8h10Lc79b9ehmaZ0tYSgIZc2NdwwUq/bzFW4YgBOBfKWl4blTgxONqkvWkcuhIwxIHVp6sVI7Q@vger.kernel.org, AJvYcCVSQfYeXxyO1sG6zfU67OPMJM15TWmWQ9/m+qap2L9iI/5JGfegpt3gEtjWf3PoEjlgOTbCBbOVUuLEVflPgas=@vger.kernel.org, AJvYcCVeBcy91TbnXqEoVolEBeR14vPUqygr5JT13wlCzg0ejgBoF4Jrkk5JB4YMUgghjH2fOfuB+iDw7Dw6@vger.kernel.org, AJvYcCWLUki49kX3utA+OExcJzKEczXWcQDfUT+2Q9Sb/AJobqYFc9vROQn/pPU32CrD6k2KkBXJn6NB+L4IO5TJ@vger.kernel.org, AJvYcCWSho1K3lGMGsX3qOb+NgNic5aY9xCZfFdrZDnFU/cIKjsXnN83eh7EbjzesBBVMA47QL43QvfvpRgG+T0=@vger.kernel.org, AJvYcCWb5AzQCwyPTOOJwaaTL4mz4FmWjyJEeSii+zC0K/xMwJj64rUZ/GChOfV2ryFV7wQTUyUZg9LC3TfH@vger.kernel.org, AJvYcCWux+3H+IP9eMNA9dZg+B7dZzNbRDrmYSrgvbIhsMwyGdudhcR8UqMiajHB/gl6//P//TpzPhXX@vger.kernel.org, AJvYcCXtzrSTqwcxwWJBkPls80l1hjGxtfdE4+6q0hi3fTKStNP3WxgekkP1kP5UBHvRGNkB2ONNtdh8SjqKbR/Meqmh@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMxd0ThdFfYCFDERPP/22yvv+mCfYCNfLjR1lsP43abuIcm02
	2q9OwJUMOnbnKqcifw4HL3tpbzQHpN/boxzP455nriTX2ulVXOMGLpgqe7+ExBpwymHMo/Bq6bW
	uIwUe2P9HufLCJSy/UQ1JmxegRcI=
X-Gm-Gg: ASbGncsTUjnQfKcpZ2kDq8GV6VEsCAbz/2/ACr2FWEXDxElHEPjgAswAk4X4TNIiQmX
	yra24z143JHQFn3lhEcOT5yHmZdVeZBC3M1nRNP0b0C0DOT6464LcBir8PAe/tCZR2QsDXpjovO
	T2v26gcTtRlb20yv/nhDrRrg3rSnhbZfdDBpbGTCqYno6CkRuQkiw9s5c=
X-Google-Smtp-Source: AGHT+IFQfth8jvV7Bf/HOqbfX7Brb6rYBsKlQ6GVbcLqvA9U4UF13IxDpTt2GrR5ecq2BkENHIaNtobIdQOlMP5DNNQ=
X-Received: by 2002:a05:6512:33c9:b0:545:5d:a5cd with SMTP id
 2adb3069b0e04-54d64a7b6a8mr2598030e87.6.1744910237922; Thu, 17 Apr 2025
 10:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-2-18ec29b1b1f3@gmail.com> <6801369a.050a0220.2b2efe.0e72@mx.google.com>
In-Reply-To: <6801369a.050a0220.2b2efe.0e72@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 17 Apr 2025 13:16:41 -0400
X-Gm-Features: ATxdqUGVXR8XPoYd_1-AlkCxTNrT7fcGAI3ugseBILGoNw_bpXd8V7C18NyvQ7c
Message-ID: <CAJ-ks9nJuojWyXtCZmnOX3EPq0xoThJ+H6PCaXFWf3Fpr6QqJA@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] rust: enable `clippy::ptr_cast_constness` lint
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

On Thu, Apr 17, 2025 at 1:12=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Apr 16, 2025 at 01:36:06PM -0400, Tamir Duberstein wrote:
> > In Rust 1.72.0, Clippy introduced the `ptr_cast_constness` lint [1]:
> >
> > > Though `as` casts between raw pointers are not terrible,
> > > `pointer::cast_mut` and `pointer::cast_const` are safer because they
> > > cannot accidentally cast the pointer to another type.
> >
> > There are only 2 affected sites:
> > - `*mut T as *const U as *mut U` becomes `(*mut T).cast()`
> > - `&self as *const Self as *mut Self` becomes
> >   `core::ptr::from_ref(self).cast_mut()`.
> >
> > Apply these changes and enable the lint -- no functional change
> > intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cas=
t_constness [1]
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  Makefile                        | 1 +
> >  rust/kernel/block/mq/request.rs | 4 ++--
> >  rust/kernel/dma.rs              | 2 +-
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 5d2931344490..7b85b2a8d371 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -481,6 +481,7 @@ export rust_common_flags :=3D --edition=3D2021 \
> >                           -Aclippy::needless_lifetimes \
> >                           -Wclippy::no_mangle_with_rust_abi \
> >                           -Wclippy::ptr_as_ptr \
> > +                         -Wclippy::ptr_cast_constness \
> >                           -Wclippy::undocumented_unsafe_blocks \
> >                           -Wclippy::unnecessary_safety_comment \
> >                           -Wclippy::unnecessary_safety_doc \
> > diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/req=
uest.rs
> > index 4a5b7ec914ef..af5c9ac94f36 100644
> > --- a/rust/kernel/block/mq/request.rs
> > +++ b/rust/kernel/block/mq/request.rs
> > @@ -69,7 +69,7 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings=
::request) -> ARef<Self> {
> >          // INVARIANT: By the safety requirements of this function, inv=
ariants are upheld.
> >          // SAFETY: By the safety requirement of this function, we own =
a
> >          // reference count that we can pass to `ARef`.
> > -        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const S=
elf as *mut Self)) }
> > +        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
> >      }
> >
> >      /// Notify the block layer that a request is going to be processed=
 now.
> > @@ -155,7 +155,7 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWra=
pper {
> >          // the private data associated with this request is initialize=
d and
> >          // valid. The existence of `&self` guarantees that the private=
 data is
> >          // valid as a shared reference.
> > -        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).a=
s_ref() }
> > +        unsafe { Self::wrapper_ptr(core::ptr::from_ref(self).cast_mut(=
)).as_ref() }
> >      }
> >  }
> >
> > diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> > index f395d1a6fe48..43ecf3c2e860 100644
> > --- a/rust/kernel/dma.rs
> > +++ b/rust/kernel/dma.rs
> > @@ -186,7 +186,7 @@ pub fn alloc_attrs(
> >              dev: dev.into(),
> >              dma_handle,
> >              count,
> > -            cpu_addr: ret.cast(),
> > +            cpu_addr: ret.cast::<T>(),
>
> Is this change necessary? The rest looks good to me.

Ah, it belongs in the preceding patch. I'll fix that on the next spin.

