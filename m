Return-Path: <linux-kselftest+bounces-29272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D289A65CA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A71885F98
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56A1C5F3F;
	Mon, 17 Mar 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq7BStlh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915119048F;
	Mon, 17 Mar 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236434; cv=none; b=TVyj3QqAuJU0Z/e0MG7WBa0lYNMfOxgEI/qxIWuLkCeiR3ybmM1DSbS9BgXxw/JWdrDbam8h+s+4F98aHM3yu+zRIW9z/JMDm63YInaSNFVAzOAYUz/R5aVeLGZD+FYdZiFi19AQOCE4FsoWHsGcOdJm2dbNFNZZHSLMH7HWsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236434; c=relaxed/simple;
	bh=ehOGcmrGZaJQniQGWoH0A1zU6UMeQK1IbOtzAOin1lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf4fHc0KDwqL7fu5m6Z+InUZNofIJOE3hGKU7yTfzrWrwCRPO1dHzhFLcZ0xgrrW6CXJMJ5dSGUgii9zs3e1wLIaUvYdIn7cdE0znFCVcgVsEfebNQo4e5WDQoGVQCs7bChAIbxh0vusdywCN/2zB9UtThbCLTtfc90i7C7gL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq7BStlh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3061513d353so59395991fa.2;
        Mon, 17 Mar 2025 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742236431; x=1742841231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RgH8a/UTVf+jUM886CjeJ+7fFyfFZ683ptFNfGfQ4E=;
        b=Xq7BStlhC2uV+7o/89RKvcRLCLmppScbfvZ/eWDMNgkfFlcHKxObU45wkw4xs9VPIp
         psb9CbihFbBjP3+lWk/gZrYW46q18kB5sfAc2Oj3EGYhh5YpeHQTgsWl+ya4eV3QviYY
         uTJceN9XW+hrrK9Vddn0bBgwMDDCV/N2ENHHNoj3rRC52F1AhA0LO0NZZgkLYApViZAk
         1rmEeG/GIVaMvkJwPFfek8IyORFb039hSE46IRKqAQXp0XfmCxMDOAQ9HO1Cr5FeePEI
         b8EDAmDisPDjNQVtl+NgDeowq08hC6Rm5OAMbRP8pHVXIumyfClpZoJ603rSbTeDAdmI
         YyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742236431; x=1742841231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RgH8a/UTVf+jUM886CjeJ+7fFyfFZ683ptFNfGfQ4E=;
        b=d/t1cZiYhgLrJOn27oZPrBeGkZ3FVbyl4KKfho8cm0JlySJGsWVi3d5iuKZwb0cm8F
         I74cdpL8JeViugwRueUbhuOmfG7ElEtTVFCONw3QglX6H1w0QJdBVRantEQvI7cIFYO2
         eKmxlIkKomIZoAu+vg+rqojP5pomLVujrKByaCvyHDMaK0BS6DU+7o7i/v9p12rj5rKX
         tAeY8VIFMAqEEFocpbHX8fhDhx72QK6InZyVQswkHTJne7uHY3zGJwa/UlGooWc8iYoU
         +hQuwNb2ypRE24aG4TujLcFDIY2OH8RGYe8gPSftmI0cKrUBC0tnxVH1k1nIY9oZqflC
         7W/A==
X-Forwarded-Encrypted: i=1; AJvYcCVAqH8Wg5tPAUlnBzExLDCv57Uto2Qd5VHeOgQ1SGsHSavOgW/IVaEHfkTl33zzNp9CvxfR9kx9YA4N1Us8fJXa@vger.kernel.org, AJvYcCVXigdoblaqLcGKpPaF9+fglXfLJCjtH75Si3xTQTcHFgimeIhAjjHP9+eBrOU7elz6dqrHDiHQW4UEBra8@vger.kernel.org, AJvYcCVgYl4jU8aYaF+tfwiHJASxcji5fqNIc0xGgxu0xw0yOQmMzVuziR2q5w+tOk5M/1GbFgcssoOi4CUja/Cg@vger.kernel.org, AJvYcCVr806qnfmtjgfoqScQD+EGxS8myD6Cgz8aXQRv+ECzoTH+6KsW30tIL8RJ2bZlfNDy0D0WLqpHuEQNrmM=@vger.kernel.org, AJvYcCW+pr9F+ww50tK4+d4ccYlVSLQ7k4jL6VAZK8vKyB8ddTPicp0Wf/33+/ngFFLGzakvcRoyz7YvVxLp@vger.kernel.org, AJvYcCWwQagfSD1i7QAx8TPkxgUryOzAcKVW1UdGXLVS3fklxj3PtBPp0YTBW1bsws9dKL8nFX7gWvLF7OW339xJz+o=@vger.kernel.org, AJvYcCXF8Tqmw8leeb27OGdjFKWzzKHswBpBiacxHZZe9ErNp98pmuQLWAXf+TGnJJrCmTn2oQ6DNQJuossj@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRIWILSn/aEBEg7rxCXkhxjf3E10AehE8fV8V2SWmKv1V+WdS
	/uE6u6kN4wlg1+RxslDCqhKNL4APFYSPeRh+HVmEu+xDlw58+68tRmkdhAOfgw//1q+udw6vm/T
	QL7ltdiLg/2tZukCm2bjOyoNY8pg=
X-Gm-Gg: ASbGnctZ0Dw1vBqU/m66tamo9h8njQdFrW7qlrHrS0Emk6AdQOR61Gf9tCwffTm6pkA
	uM7t/FsI6wfQzaq4tzHTAVIUwoAObRduagV2nORoKpmjkiUwa4t0JvEpSp9haMbEAH/yQztZIxl
	S4SpjN2P8SxsfXTSeUgeUmpL1aaSOYgNp5mWXZAQEN/Zw3JHaqjJyZ+DEFmBmR
X-Google-Smtp-Source: AGHT+IEuOyU1EAIZGNPcU1UQpVvmze5Fv4puhAbwE4i2xu3ParhHBig+KUJCu/9ANLld3Xe0NJ1pTjvfSHUJlGkg4r0=
X-Received: by 2002:a2e:7819:0:b0:30b:b204:6b98 with SMTP id
 38308e7fff4ca-30c97543facmr9366801fa.12.1742236430751; Mon, 17 Mar 2025
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <D8IQCJHJWPNJ.1J2UO4OK0D0B3@proton.me>
 <CAJ-ks9=cBEZqPHMWsh7-c16LTg+i+RmDFigwy81o9yOj2J+jFA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=cBEZqPHMWsh7-c16LTg+i+RmDFigwy81o9yOj2J+jFA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 14:33:14 -0400
X-Gm-Features: AQ5f1JrVwUf05ntBkD98vS-EcZTcBLddhaoJo6_SZObmEIDvKFbJY6SKC0TNZzk
Message-ID: <CAJ-ks9nCdcn7ajG69m+2QTgYxvELd2h7kdBb_bLpTwQbnZ8X_Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Mar 17, 2025 at 1:50=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
> > > Throughout the tree, use the strict provenance APIs stabilized in Rus=
t
> > > 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> > > functions at the `kernel` crate root along with polyfills for rustc <
> > > 1.84.0.
> > >
> > > Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc =
<
> > > 1.84.0 as our MSRV is 1.78.0.
> > >
> > > In the `kernel` crate, enable the strict provenance lints on rustc >=
=3D
> > > 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introduci=
ng
> > > compiler flags that are dependent on the rustc version in use.
> > >
> > > Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-p=
rovenance-apis [1]
> > > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > > Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.m=
e/
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >
> > One comment below, with that fixed:
> >
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> >
> > > ---
> > >  init/Kconfig           |   3 ++
> > >  rust/kernel/alloc.rs   |   2 +-
> > >  rust/kernel/devres.rs  |   4 +-
> > >  rust/kernel/io.rs      |  14 +++----
> > >  rust/kernel/lib.rs     | 108 +++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  rust/kernel/of.rs      |   2 +-
> > >  rust/kernel/pci.rs     |   4 +-
> > >  rust/kernel/str.rs     |  16 +++-----
> > >  rust/kernel/uaccess.rs |  12 ++++--
> > >  9 files changed, 138 insertions(+), 27 deletions(-)
> >
> >
> > > +#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> > > +mod strict_provenance {
> > > +    /// Gets the "address" portion of the pointer.
> > > +    ///
> > > +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.=
html#method.addr.
> > > +    #[inline]
> > > +    pub fn addr<T>(ptr: *const T) -> usize {
> > > +        // This is core's implementation from
> > > +        // https://github.com/rust-lang/rust/commit/4291332175d12e79=
e6061cdc3f5dccac2e28b969 through
> > > +        // https://github.com/rust-lang/rust/blob/1.84.0/library/cor=
e/src/ptr/const_ptr.rs#L172
> > > +        // which is the first version that satisfies `CONFIG_RUSTC_H=
AS_STABLE_STRICT_PROVENANCE`.
> > > +        #[allow(clippy::undocumented_unsafe_blocks)]
> > > +        unsafe {
> > > +            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
> > > +            core::mem::transmute(ptr.cast::<()>())
> > > +        }
> >
> > I think we should just use `ptr as usize` here instead. It's going away
> > at some point and it will only affect optimizations (I don't even know
> > if they exist at the moment) of old versions.
>
> Why get cute? I'd rather defer to the standard library.

Ah, this is gone anyway with Boqun's suggestion - this function exists in 1=
.78.

