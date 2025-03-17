Return-Path: <linux-kselftest+bounces-29275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F46A65D41
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F6E7AB5A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5061E1DE8;
	Mon, 17 Mar 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkGRkVNp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6095143748;
	Mon, 17 Mar 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237446; cv=none; b=RbSJFLC8bKW1Tz7ehSzztQos0qiwo4LYaNnPG9CeT69WjX4FomXdgXxBJ8K/1xAtLjT+s1aygSUQR/lXv61f8WUo5PWdlsJvbqQC6hiHIFwS1vF6sdN7aKnOAvIoXRknvGCEDu1hL3Vmw0Fw8/gebB7BG58SSW2+t1lYtJr7eYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237446; c=relaxed/simple;
	bh=PqQDfWDHqdxebzalktwINDV4sa1k08bacQNFgioeyPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxTM8Eo8sROG6DE8i19fmu/eZghIAKXQcLaYoiGNEE390TNjc8RiEf7tJCE/qTKwmppN/6mKt693kjS8eP3nK/tCs07Ka+aGlE1/fWc47ldEoQxHabbu7Cj7D/ca9SGI2yW8+m9P04QY9oPZUxl1BAnt5old/rWrN20jU7FBMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkGRkVNp; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30762598511so50288081fa.0;
        Mon, 17 Mar 2025 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237443; x=1742842243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdsuVb+NO059jE7CUp+DstvEYjAUR4RmTp/HM/dio+s=;
        b=QkGRkVNpf7ZtmidSdGOaAfZ2YH15hXHT4Lh4YglFo3VQJ772jkEr71Nfi88ftIqNUQ
         XVRXF5EQ9o4yW95Q2IGvbzTOPoq7NppGMWqELizOhoM9CV9no29tCDVZZrLOQu1VmHRH
         rsz05n1vIVTF03M3qRhrk+qSYn3v7kgHAcmTlI68chB78jAla90lCB7YMCgH203wdbBK
         9W6z9RJ3maRXVRYigAOK5k02zr18+By5gswjxvigHH9xssqVbBNhrfTGMtEZLdgW9Nwy
         5e4HlIezLNjdFffPrsb8zSm9APn6jklNBzZm0YqLsOWf4QKxWSVgksHuHulJ9EBl8G1B
         Hx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237443; x=1742842243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdsuVb+NO059jE7CUp+DstvEYjAUR4RmTp/HM/dio+s=;
        b=CpE9MVa1LXomMW617DiV7SmWPHzcmQFzn6ro4dre/TZj7TBWVDcOfqVmwGmA9FBAJh
         PZGAup6aLn+7PFIuytkYOMzUh0Oj1zriJotND5EyVdY3hpnn+99oR7AMTNdxcRnfXskH
         0sMgTjgh8fsu5E7u+X6h8cxY1uiIxH73mJhvuAujPI6+2hcSaFexSWLH1XoK7JrNvlxZ
         HdexW3M1g/fQQk7JnSNUykB3nK0nj/mDMjyN0taOq93Gc2E0PJGMZczDt5vI6n9Yiz2G
         UEsEn+I/t/eAkWus7oyHzh9CvcDao4mO2dGNeoqHhEd3iK2w5WNwbRAj6hMgbmTiRole
         mBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOF4fCCJBAmi3TNDo2zoq4OZ8793ll3F/XMdeR4T7Uwj5njNzzEBe9oVfqxlpi5S1tZfUI/d2rD+vlbURgeHA=@vger.kernel.org, AJvYcCVTdI87rbODNKEd2bc7La5FdI9OH8RXKZ5norPYYMprzUn6aXArf5QJyfU/9P0eBHhCNumLrZCO2kD7@vger.kernel.org, AJvYcCVzt78ACWJiJ7Y042dKPJsgjzw6+pggHljyCox7pFyRqFvoKgkJcbLej7VaE49vsFtv2Lw6cBRvh97G/wMJ@vger.kernel.org, AJvYcCWb9T4sfB4tJuWCUnY2GeFChmWF9Rc8siQFiQxn7tLXI6B9omuj55hsCaanPkwBd8vgjzolJKBjtraoY1bH@vger.kernel.org, AJvYcCXEbVj/kZRyPtY0qHwxTBnHVt1We/eJ/EwXB4W8r0/oS5uN5OAH9LNMm2TWsZBxWz/2Y/CE1AATgCCj@vger.kernel.org, AJvYcCXX5fzkq90lKS+0e6VN9mFLAffa4WcGjSNXAU4XLH9xUNj0GGe5oyHxycjp4cqTq4p2m1KZ4j+n3PYxo+q+FJZe@vger.kernel.org, AJvYcCXfvVdxV97gwwPBEhNjiMd+Mlm+fJls9Eez2uvf48au11YG06w7dlYlk2W0eM5zlIiqaUBOInxYIqGaQig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLRuuEiJOatQ7HWSMeun0TNzWKgY3Xda10HD7SFBMl52ee2ez
	u3rzfMQqXwbNc2HbOlDPjmYUUk3HM1Sf82bYrH/bWMPW6/z2qxJ4yOQu7AbT2Tm3PdcdqXstOHP
	nVphE+ksdoS8Xr8pN/IvtfGNV/cQ=
X-Gm-Gg: ASbGnctJgjrqOpF8NAa9oO2Hh1CmCrjx31vPFuHQQHmEvg55M0zf7Chlz3FFWsGzsht
	TCMwUg1/+ZqAsM1BYnpQPiDQ7Qb3E28KNJ6MHFnPQBUPm5PJdpiZO/RDsLMaRTuXipdE3VjySwA
	gpqjngOyQz4/37yPYPvh7yWYU1KLouYRJi0Ah+2d7IztLX3ZBUP17BVCH3ao0=
X-Google-Smtp-Source: AGHT+IEzp2oVvJ71QS1eAcjxHAeO5azoLiAY06CVQGLhW64REy+cGH7ce9uGBgUaWzXBdua6Xa8H3vynwoCxmiZ9VtA=
X-Received: by 2002:a05:651c:a0b:b0:30b:b132:43e5 with SMTP id
 38308e7fff4ca-30c4a876b4fmr79062201fa.19.1742237442567; Mon, 17 Mar 2025
 11:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com>
In-Reply-To: <67d8671d.050a0220.3305ab.6372@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 14:50:05 -0400
X-Gm-Features: AQ5f1JpDW6g4t98rfmSJ41m0LaHQtaEbfDWcYhYq7ATuhgE6QuNUhsWrpqWF0G0
Message-ID: <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 2:17=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 02:10:42PM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 2:06=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 02:04:34PM -0400, Tamir Duberstein wrote:
> > > > On Mon, Mar 17, 2025 at 1:39=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> > > > > [...]
> > > > > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > > > > index fc6835cc36a3..c1b274c04a0f 100644
> > > > > > --- a/rust/kernel/lib.rs
> > > > > > +++ b/rust/kernel/lib.rs
> > > > > > @@ -17,6 +17,11 @@
> > > > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coer=
ce_unsized))]
> > > > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(disp=
atch_from_dyn))]
> > > > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsi=
ze))]
> > > > > > +#![cfg_attr(
> > > > > > +    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
> > > > > > +    feature(strict_provenance_lints),
> > > > > > +    deny(fuzzy_provenance_casts, lossy_provenance_casts)
> > > > > > +)]
> > > > > >  #![feature(inline_const)]
> > > > > >  #![feature(lint_reasons)]
> > > > > >  // Stable in Rust 1.83
> > > > > > @@ -25,6 +30,109 @@
> > > > > >  #![feature(const_ptr_write)]
> > > > > >  #![feature(const_refs_to_cell)]
> > > > > >
> > > > > > +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> > > > > > +#[allow(clippy::incompatible_msrv)]
> > > > > > +mod strict_provenance {
> > > > > > +    /// Gets the "address" portion of the pointer.
> > > > > > +    ///
> > > > > > +    /// See https://doc.rust-lang.org/stable/core/primitive.po=
inter.html#method.addr.
> > > > > > +    #[inline]
> > > > > > +    pub fn addr<T>(ptr: *const T) -> usize {
> > > > > > +        ptr.addr()
> > > > > > +    }
> > > > > > +
> > > > >
> > > > > For addr(), I would just enable feature(strict_provenance) if
> > > > > CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE=3Dn, because that featu=
re is
> > > > > available for 1.78. Plus we may need with_addr() or map_addr() in=
 the
> > > > > future.
> > > >
> > > > We still need these stubs to avoid `clippy::incompatible_msrv`, and
> > > > we'll need those until MSRV is above 1.84.
> > > >
> > >
> > > Hmm.. why? Clippy cannot work with unstable features?
> >
> > Yes, `clippy::incompatible_msrv` doesn't pay attention to enabled
> > unstable features.
>
> Then we should fix clippy or how we set msrv rather adding the stub.
> @Miguel?

I filed https://github.com/rust-lang/rust-clippy/issues/14425.

