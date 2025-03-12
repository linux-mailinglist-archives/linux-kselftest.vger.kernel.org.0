Return-Path: <linux-kselftest+bounces-28816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3E8A5DFE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BB016D15B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FC2505DE;
	Wed, 12 Mar 2025 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiWJvCv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4C183CD9;
	Wed, 12 Mar 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792460; cv=none; b=J2d/65eHiHXkYkU4++WGFLyO93RriT2fRJNR+FUivxLVt3kEaAxiSKuzgFr/u8MaAi9Usq9zjBiTiy/4wH7eYYYtuOZuzpbNpBk/PyZrg2i+3i9srbEOt6GUbvzdpDRUDLz0mYoyL+IsELQab4+fmA6xsvg0gr5AO1wY3YQ8OJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792460; c=relaxed/simple;
	bh=ZUrIFY2RmqH5+5+XoOd4Ss8z8BQkL0er2jTcsOooub8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCvM7S4dtOYJQ4+0kzXEJ0ucg+D5WyXgM+UIi3P0GWb6Mrh7P+AeN8oRi2pq0qGjrpQLorqgkQwjEbSLEik5ttb2FCoaNEPFAQZ8ZhZ5YAXElgx1dogJMpRO9P2QJMby7eMhfbwXL59LADHQchXMpqEih582Dg/Ot8O06nHrOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiWJvCv/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so10264332a12.0;
        Wed, 12 Mar 2025 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792456; x=1742397256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxrIqqxfx2bgrYEWWHXdn+PPitQZRqnM1FbC7V9vc4Y=;
        b=jiWJvCv/hQ5aBgcN0WZ45pmlMpc87PEhvfoa4BAPOSgH+uJJK02oS/cmvb23ZEqPpk
         J/9nA8pKiu5Qb+1RwUBKU+MJSapQwjYTEykLzXbVg44tr6KWknyLIs1XfvYSOeN8fT98
         wB/9smFn08wWF/2hqW+UTFEu7CWtl0q38tJFtKCxcoezmyBCWVAGH8+8bFv0aeCQozLF
         8dZ7LDqGBMHi4SlHLwq0UVc/kAuS6vBtC+HSjI6MWl40jMxyoQ+D8fpGkS6pQEyzXIAu
         qst74ghr9SG0/kmxEcp5xSdPKAqG8EmT1ThRuqpmOcBdGJKMypdyN7d6ANKXzsn9KvD+
         cmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792456; x=1742397256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxrIqqxfx2bgrYEWWHXdn+PPitQZRqnM1FbC7V9vc4Y=;
        b=UozuvEJUpdmANwdobpV0MOre6guj8QDO/vl49vh60DCkZyiOTnFRdUOmGdJVtQOQXq
         VUE4gbfh08S8Z194kGwLF7p3941W/WdzEGhJqS0DXjlI0j+CwVmbdfPvnlnpoEfoz2Bd
         zfnrB1zMpiIBl0mING3kskxNJYeylspRGSUJ3eL9KxOSvzxus2dCH1AkBUfMvZwuNFYZ
         BQKnw43PBkGgpoONwFXHQDtaUvnsR/bgA2yB/KKt/vgRhg+v7oAn6fi1ynL3lAd7ixwo
         hd2a0lOrsFEENFkQyCnA2jMMU9hkT5FZEfhNA1hm7TD0qr4xiAxsRxRbggCAAieA7dZd
         ViVw==
X-Forwarded-Encrypted: i=1; AJvYcCUdfnklDhZlL5kaVk42J2nDOIpaoTiwjPAyBaobknPBaQJyIqIt/j3BCoNNQ8/6eLIJKAz7mkNbN6p5Kwc+@vger.kernel.org, AJvYcCUi6W0UBP1Vds2dV85NPChDNuUgvhBIwfWTE84brKAKOffVhmfjLaieACuq5JBcBNsi+aD2uebY1JMA@vger.kernel.org, AJvYcCVEOAQRjlnEUfXMJRUsH8JjtZsQV3MYihKD4x5ZbVJgKO+PZBhc0e3cm7uWBocZi8/H7ruTiV6ejNBgb7+52BNJ@vger.kernel.org, AJvYcCWdzjHRpYHIbSrKmGGBdWuU5AFl6VJbi3nIdW0WTwlRAdicze/RXbNxacVk/IJhrbOkKz4AbGof/eNO5zV0ERg=@vger.kernel.org, AJvYcCX9YA4rnR5FwEani87SwaCnYXL5uTeTjf8T70MdwN/zLFPY+cG73AihxrpPBD120nYb/btqzBR+dyhq@vger.kernel.org, AJvYcCXVqcpe6uuf0YignIgzWrYUjvyErwTzg6haCCbrvAdSMVEJDWOyAmN8zKqLqRFbAOeXb/ik+6txJ6TFflc=@vger.kernel.org, AJvYcCXtk+hE5By1d1+NQIiUpX++5Rxr+q0+cPqUXQftfhoHxUlCXYzQfV8H9Gc3AJdy4BqMsbiQQoZF/EXFfi/Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fe7CAErHgHAKeVJDv+xkZEfy5NICHhlQAqnJNjDwn32FY4JC
	D/l6MyCyVPcaqdkf3bUPaC7fRB49Qwlx9ekR0QqRXpozE2o/BTtsQshakErSkWV6vln3PDR5iqQ
	Txk8m8psSDKYDW3qjTkuUzA3lhCY=
X-Gm-Gg: ASbGncskTj0dS6OwYiDfkOpa3ddx0k2fpsF0032BkjhQgpbbhsbnj4tgVvsMfKETvdb
	4L9IH+XwPWBTfzZ+S5ZjPkfJzIijQB0pXr0+xACQFgLFtsq7FuKotNBSn0EWBz4ZmBiID26F/+y
	eRe7OnoHJaZ7CIG7VfOaJA0XSjiNpEOvtgvFPi5w/5sw==
X-Google-Smtp-Source: AGHT+IH2DiJwy3ZvuXECEd4LF5f8Tg4iFRwMcRUoSF/ffcGW5c4Fh1bf/0ekZaD7abOlDe7Vm5+u0myH7PuuT0AgCYU=
X-Received: by 2002:a17:907:3d9e:b0:ac2:d2dd:87f4 with SMTP id
 a640c23a62f3a-ac2d2dd95edmr616943066b.44.1741792456095; Wed, 12 Mar 2025
 08:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-1-25d60ad922b7@gmail.com> <D8ECSHQTFGM5.E4N1XJBDTJUY@proton.me>
In-Reply-To: <D8ECSHQTFGM5.E4N1XJBDTJUY@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 11:13:39 -0400
X-Gm-Features: AQ5f1JqDciD88026nhyTgaQr2HJFyD0HlPPeqLw4m_GUEXVJmf1ZKY6IODNWsLA
Message-ID: <CAJ-ks9k_sq8CGxij6zFTkR9c75pDAGsHZ1B=aDew7FnbUz0uCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] rust: retain pointer mut-ness in `container_of!`
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

On Wed, Mar 12, 2025 at 10:22=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> > Avoid casting the input pointer to `*const _`, allowing the output
> > pointer to be `*mut` if the input is `*mut`. This allows a number of
> > `*const` to `*mut` conversions to be removed at the cost of slightly
> > worse ergonomics when the macro is used with a reference rather than a
> > pointer; the only example of this was in the macro's own doctest.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> One tiny nit below, but even without that:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > ---
> >  rust/kernel/lib.rs      |  5 ++---
> >  rust/kernel/pci.rs      |  2 +-
> >  rust/kernel/platform.rs |  2 +-
> >  rust/kernel/rbtree.rs   | 23 ++++++++++-------------
> >  4 files changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 7697c60b2d1a..9cd6b6864739 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -187,7 +187,7 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
> >  /// }
> >  ///
> >  /// let test =3D Test { a: 10, b: 20 };
> > -/// let b_ptr =3D &test.b;
> > +/// let b_ptr: *const _ =3D &test.b;
>
> You could also use `&raw test.b` to get a pointer instead of relying on
> the pointer coercion. That syntax is stable since 1.82.0, so older
> compilers would need to enable the `raw_ref_op` feature.
>
> I created an orthogonal good-first-issue for changing uses of
> `addr_of[_mut]!` to `&raw [mut]`, so maybe that can also be done there:
>
>     https://github.com/Rust-for-Linux/linux/issues/1148

Thanks for doing that! Yeah, I think moving to that syntax would be
good but as you say requires enabling the feature and/or bumping the
rust version, so it can't be done here directly.

